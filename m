Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTJBPdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJBPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 11:33:38 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:24588 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263359AbTJBPdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 11:33:36 -0400
Date: Thu, 2 Oct 2003 17:33:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031002153301.GA2033@win.tue.nl>
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 08:39:50AM -0600, Eric W. Biederman wrote:

> This is a 2.7 project.

I disagree. This is unrelated to kernel development, just like working
on sparse is unrelated to kernel development. 

> Doing this right requires a lot more
> than what you are doing here.

Possibly. So we need discussion.

I have registered comment #1: Al prefers the enum style.
A possibility.

Now you come with comment #2: write LINUX_MS_RDONLY instead of
MS_RDONLY. You have not convinced me.

> One example is that we need to be very careful with is that the
> glibc abi is not the same as the linux kernel abi.  Even though most
> of the functions are pass through some are not.  And which are which
> is a fairly arbitrary decision.  So all of the definitions exported
> through linuxabi need to be in a linux centric namespace.  This is
> especially true because otherwise I could not include
> linuxabi/mountflags.h and sys/mount.h and not get compilation 
> conflicts.

Today glibc tells me in sys/mount.h
 #define MS_RMT_MASK (MS_RDONLY | MS_MANDLOCK)
and in linux/fs.h
 #define MS_RMT_MASK (MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|MS_NODIRATIME)

It seems glibc is not even self-consistent.
Consider linuxabi/mountflags.h as part of the replacement for linux/fs.h.

Andries


