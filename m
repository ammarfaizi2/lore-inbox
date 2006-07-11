Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWGKSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWGKSDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGKSDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:03:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5027 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751163AbWGKSDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:03:23 -0400
Message-ID: <44B3E7D5.8070100@zytor.com>
Date: Tue, 11 Jul 2006 11:03:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de>
In-Reply-To: <20060711171624.GA16554@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> There is always some sort of prereq when new features get added.
> Documentation/Changes has a long list. Some setup need more updates,
> some need fewer updates. No idea what your experience is.
> Old klibc was trivial to build (modulo that kernel header mess), and I
> expect that kinit handles old kernels.
> 

One more thing on this subject... "modulo that kernel header mess" is 
just as much a reflection of the fact that the Linux ABI really isn't 
particularly stable.  glibc contains a huge amount of code to deal with 
different kernel versions.  klibc will not be doing this; in general old 
klibcs should continue to work (but may not compile against a newer 
kernel), but a newer klibc may not work on an older kernel.

	-hpa
