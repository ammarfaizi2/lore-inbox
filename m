Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWD3RHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWD3RHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWD3RHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:07:49 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:59742 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1751181AbWD3RHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:07:49 -0400
Subject: Re: World writable tarballs
From: Mark Rosenstand <mark@borkware.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Heikki Orsila <shd@zakalwe.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <200604301351.55136.s0348365@sms.ed.ac.uk>
References: <1146356286.10953.7.camel@hammer>
	 <200604301249.16259.s0348365@sms.ed.ac.uk>
	 <1146400614.15178.14.camel@hammer>
	 <200604301351.55136.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 19:08:15 +0200
Message-Id: <1146416895.15178.24.camel@hammer>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 13:51 +0100, Alistair John Strachan wrote:
> On Sunday 30 April 2006 13:36, Mark Rosenstand wrote:
> > On Sun, 2006-04-30 at 12:49 +0100, Alistair John Strachan wrote:
> > > Going over old ground again, any administrator a) compiling the kernel as
> > > root or b) relying on GNU tar to make _security policy decisions_ is
> > > completely insane.
> >
> > Yes, GNU tar is acting insane. Given that GNU tar is the most widely
> > used tar implementation (at least for extracting linux sources), why is
> > the kernel packaged to exploit this insane behaviour?
> 
> I think you're missing the point. The tar archive can have whatever the hell 
> permissions it likes; you as the user of tar and risking extraction as root 
> should know what tar does and (if you care) take action to negate it.
> 
> Even back before the kernel tar files made every file writable by all, there 
> were always a few files that were marked executable (!!) by all. Bottom line: 
> you can't rely on the permissions in the tar files.

I think you are missing the point. The point is that the kernel source
gets extracted with world writable permissions, without any reason.

I am fully aware that you cannot trust the permissions of extracted tar
archives with GNU tar unless you explicitly add an unreasonably long
argument, whereas other tar implementations require you to use the p
flag.

The question is: Is it right to exploit this misbehaviour?

> (You probably aren't aware of the recent bug found in the kernel build system 
> where, if compilation was executed as root, it would overwrite the /dev/null 
> node with a regular file -- now THAT'S a security problem!)

Yes, that is indeed a good argument for not building as root. But please
try to stay on the fucking subject or be quiet.

