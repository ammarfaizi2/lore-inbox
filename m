Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWDCPkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWDCPkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWDCPkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:40:41 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:7142
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751732AbWDCPkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:40:40 -0400
From: =?iso-8859-2?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
Reply-To: edwin@gurde.com
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
Date: Mon, 3 Apr 2006 18:39:38 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net,
       Stephen Smalley <sds@tycho.nsa.gov>
References: <200604021240.21290.edwin@gurde.com> <Pine.LNX.4.64.0604031117070.7743@d.namei>
In-Reply-To: <Pine.LNX.4.64.0604031117070.7743@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604031839.38590.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 18:18, James Morris wrote:
> On Sun, 2 Apr 2006, Török Edwin wrote:
> > Before continuing the work on it, I ask for your advice, and comments on
> > what I've done so far.
>
> I would suggest dropping your LSM stuff and just using SELinux.  It's
> crazy to try and reinvent it.
I am not trying to reinvent SELinux. But I do not know how to accomplish what 
I want with SELinux.

Here it is what I want:
- have security labels applied to sockets based on their owners (ok, I guess 
SELinux does this by default)

- the security labels of processes be assigned based on their executable's 
inode+mountpoint.
Is there a way to do auto-labeling with SELinux? I mean having a security 
context applied based on the inode, without me having to run 'make relabel', 
setfiles, and so on....
Let's say I compile&install a program. Can it have a security label 
auto(magically) applied, based on the inode of its executable? (without 
recompiling, & reloading the policy)

(From my very limited understanding of SELinux, this would mean creating a 
context for each executable, that is altering the policy, if each executable 
needs to have a separate context. Is it possible to dinamically generate the 
context at runtime? Is it possible to integrate my autolabel.c with SELinux?)

It doesn't have to have a security label applied by its inode, but that is 
unique, I don't know how secure would it be to identify processes by path...

If the above is possible, could you please provide pointers to documentation?

How can I implement auto-labeling with SELinux? (is there a possibility to 
write some sort of plugins that provide this functionality?)

To sum up, I wrote my LSM stuff because I didn't know how to use SELinux to 
accomplish what I wanted. 
If it can be done with SELinux easily, I'm happy to switch to that. (easy from 
the end-user's perspective, using fireflier for example. it doesn't matter 
how much work it would imply to make fireflier handle the stuff "behind the 
scenes")

Thanks in advance,
Edwin
