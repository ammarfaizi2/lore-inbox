Return-Path: <linux-kernel-owner+w=401wt.eu-S1751929AbWLNBJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWLNBJ2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWLNBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:09:27 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:33128 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbWLNBJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:09:27 -0500
Subject: Re: hrtimer.h
From: Steven Rostedt <rostedt@goodmis.org>
To: Ariel =?ISO-8859-1?Q?Ch=FFffffe1vez?= Lorenzo <achavezlo@yahoo.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <248625.39629.qm@web26101.mail.ukl.yahoo.com>
References: <248625.39629.qm@web26101.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 13 Dec 2006 20:09:24 -0500
Message-Id: <1166058564.1785.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 01:42 +0100, Ariel Chÿffffe1vez Lorenzo wrote:
> Hi,
> 
> Since the kernel 2.6.18 has incorporated the high
> resolution timer itself, I'm trying to test it, but on
> my GNU/Debian I can't figure out how to include
> hrtimer.h, that is on /usr/src/linux/include/, the
> headers.
> 
> I use the following command to try to compile it.
> 
> gcc -D__KERNEL__ -I /usr/src/linux/include ex.c
> 
> 
> ex.c is just the inclusion of hrtimer.h
> 
> #include <linux/hrtimer.h>
> int main()
> {
>  return 0;
> }
> 

As stated, the kernel headers have nothing to do with user space code.

But I'll educate you a little more.

First, high resolution timers are not in 2.6.18.  The hrtimers are, but
the actual meat that makes them high resolution wont be in until
(hopefully) 2.6.20 (or perhaps a little later).

To use the high resolution timers (when they are in), you don't need to
do anything special.  nanosleep, and all the posix timers will get them
automatically.

-- Steve


