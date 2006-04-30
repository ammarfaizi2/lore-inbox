Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWD3Mvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWD3Mvp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWD3Mvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:51:45 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:56078 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751105AbWD3Mvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:51:45 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark Rosenstand <mark@borkware.net>
Subject: Re: World writable tarballs
Date: Sun, 30 Apr 2006 13:51:55 +0100
User-Agent: KMail/1.9.1
Cc: Heikki Orsila <shd@zakalwe.fi>, linux-kernel@vger.kernel.org
References: <1146356286.10953.7.camel@hammer> <200604301249.16259.s0348365@sms.ed.ac.uk> <1146400614.15178.14.camel@hammer>
In-Reply-To: <1146400614.15178.14.camel@hammer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301351.55136.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 April 2006 13:36, Mark Rosenstand wrote:
> On Sun, 2006-04-30 at 12:49 +0100, Alistair John Strachan wrote:
> > Going over old ground again, any administrator a) compiling the kernel as
> > root or b) relying on GNU tar to make _security policy decisions_ is
> > completely insane.
>
> Yes, GNU tar is acting insane. Given that GNU tar is the most widely
> used tar implementation (at least for extracting linux sources), why is
> the kernel packaged to exploit this insane behaviour?

I think you're missing the point. The tar archive can have whatever the hell 
permissions it likes; you as the user of tar and risking extraction as root 
should know what tar does and (if you care) take action to negate it.

Even back before the kernel tar files made every file writable by all, there 
were always a few files that were marked executable (!!) by all. Bottom line: 
you can't rely on the permissions in the tar files.

Even if the world writable thing is fixed (obviously I would not be opposed to 
this), I _strongly_ recommend that you add the two flags to tar as a root 
user so that ANY tar you extract will be extracted with 100% guaranteed safe 
permissions..

(You probably aren't aware of the recent bug found in the kernel build system 
where, if compilation was executed as root, it would overwrite the /dev/null 
node with a regular file -- now THAT'S a security problem!)

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
