Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWGYLvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWGYLvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGYLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:51:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49162 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932329AbWGYLvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:51:05 -0400
Date: Sat, 15 Jul 2006 16:54:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
Message-ID: <20060715165450.GE9849@ucw.cz>
References: <1152897878.23584.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152897878.23584.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> SLIM inherently deals with dynamic labels, which is a feature not
> currently available in selinux. While it might be possible to
> add support for this to selinux, it would not appear to be simple,
> and it is not clear if the added complexity would be desirable
> just to support this one model. (Isn't choice what LSM is all about? :-)
> 
> Comments on the model:
> 
> Some of the prior comments questioned the usefulness of the
> low water-mark model itself. Two major questions raised concerned
> a potential progression of the entire system to a fully demoted
> state, and the security issues surrounding the guard processes.
> 
> In normal operation, the system seems to stabilize with a roughly
> equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
> applications seem to do a fixed set of operations in a fixed domain,
> and stabilize at their appropriate level. Some applications, like
> firefox and evolution, which inherently deal with untrusted data,
> immediately go to the UNTRUSTED level, which is where they belong.
> In a couple of cases, including cups and Notes, the applications
> did not handle their demotions well, as they occured well into their
> startup. For these applications, we simply force them to start up
> as UNTRUSTED, so demotion is not an issue. The one application
> that does tend to get demoted over time are shells, such as bash.
> These are not problems, as new ones can be created with the
> windowing system, or with su, as needed. To help with the associated
> user interface issue, the user space package README shows how to
> display the SLIM level in window titles, so it is always clear at
> what level the process is currently running.

This -- or preferably some better explanation -- needs to go into
Documentation somewhere.

Is this supposed to protect my ~/.ssh/private_key from mozilla?

How will it work in case such as ssh? It takes password / reads
private key I care about, then communicates with remote server...

> As mentioned earlier, cupsd and notes are applications which are
> always run directly in untrusted mode, regardless of the level of
> the invoking process.

So I will not be able to print my private key?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
