Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTBJLXE>; Mon, 10 Feb 2003 06:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTBJLXD>; Mon, 10 Feb 2003 06:23:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38928 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266978AbTBJLXC>;
	Mon, 10 Feb 2003 06:23:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: devnetfs <devnetfs@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling kernel with debug and optimization 
In-reply-to: Your message of "Mon, 10 Feb 2003 03:11:51 -0800."
             <20030210111151.31800.qmail@web20418.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Feb 2003 22:32:37 +1100
Message-ID: <2721.1044876757@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003 03:11:51 -0800 (PST), 
devnetfs <devnetfs@yahoo.com> wrote:
>Does compiling with -g option degrade performance? IMO it should NOT.

Compiling with -g slows down compilation and link, mainly because of
the extra debugging data that has to be copied around.  -g
significantly increases disk usage.

>If that's true, then why dont we compile kernels with both -g and -O2
>always? Also does using -g AND -O2 cause some optimizations to be 
>missed out?

With gcc, compiling with -g should have no effect on the kernel.  One
of my occasional tests is to build vmlinux with and without -g, run
both through strip -g and compare the results.  They should be
identical except for the build timestamp.

