Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVEITKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVEITKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVEITKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:10:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261471AbVEITKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:10:41 -0400
Date: Mon, 9 May 2005 15:09:51 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
cc: Chris Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
In-Reply-To: <200505092044.29440.ks@cs.aau.dk>
Message-ID: <Xine.LNX.4.44.0505091508060.6382-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Kristian Sørensen wrote:

> On Monday 09 May 2005 19:54, Chris Friesen wrote:
> > Kristian Sørensen wrote:
> > >  By "secure IPC" is meaning a
> > > security mechanism that provides a more fine granularity of specifying
> > > who are allowed to send (or receive) messages... and maby also a way to
> > > resolve the question of "Can I trust the message I received?"
> >
> > How about unix sockets?
> > 	--you can have sockets in the filesystem namespace with regular file
> > permissions to control who is allowed to send messages to particular
> > addresses
> This is the same problem: Basing access control on user and group is not 
> enough - especially as the root-user can overrule any access control 
> specified by the normal DAC file attributes.

You want MAC, in other words.

SELinux probably does what you want with fine grained MAC for Unix domain
networking and SO_PEERSEC for peer authentication.


- James
-- 
James Morris
<jmorris@redhat.com>


