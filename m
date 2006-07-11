Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWGKSWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWGKSWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGKSWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:22:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2772 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932077AbWGKSWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:22:43 -0400
Message-ID: <44B3EC5A.1010100@zytor.com>
Date: Tue, 11 Jul 2006 11:22:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de>
In-Reply-To: <20060711181552.GD16869@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> "It would be nice if ..." someone can build a list of things that
> changed over time. Say from 2.0.0 to 2.6.18. Just struct layouts and defines.
> 
> I havent tried it, but one would hope that the /bin/ls from SuSE 5.3 still
> works today.  Guess its time for me to actually try that the next days.

You know how much code there is in glibc to make your /bin/ls still work?

That being said, it in general isn't a problem to continue to use the 
same exact sets of system calls, but that also means skipping any new 
functionality.  In recent memory that includes things like 64-bit file 
offsets and high signals, even more recently it means things like 
openat() and splice().  A full-blown libc also has to deal with 
LinuxThreads version NPTL.  Etc.

Again, I fully expect that klibc-0.1 still works on the current kernels, 
but current klibc wouldn't work on 2.4 kernels.

	-hpa
