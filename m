Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWGAPXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWGAPXE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWGAPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:23:04 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39077 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751540AbWGAPXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 11:23:01 -0400
Message-ID: <44A69334.3010309@zytor.com>
Date: Sat, 01 Jul 2006 08:22:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain>
In-Reply-To: <1151751417.2553.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Bailey wrote:
>> Either the kernel can unconditionally invoke /kinit, which then would 
>> invoke the users /init if present, or the swsusp can be a separate 
>> initramfs binary which the user's initramfs gets to invoke (the second 
>> is arguably neater, but requires minor changes to the users initramfs.)
> 
> The Ubuntu initramfs doesn't use kinit, and it would be nice if we
> weren't forced to.  We do a number of things in our initramfs (like a
> userspace bootsplace) which we need done before most of the things kinit
> wants to do take place.
> 
> kinit is a nice default tool but longer term, I almost imagine it as a
> busybox type of setup.  Either you say "go" and it brings up the system,
> or you call it with an argument, change argv[0] or something to get just
> the functionality asked for.

Modularity is good; in general I think the busybox model of one 
overgrown binary is probably not the right idea, but it depends of 
course on the specifics of the problem.

	-hpa

