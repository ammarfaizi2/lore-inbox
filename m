Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423320AbWF1Pdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423320AbWF1Pdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423367AbWF1Pdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:33:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62940 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423320AbWF1Pdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:33:39 -0400
Message-ID: <44A2A147.9020501@zytor.com>
Date: Wed, 28 Jun 2006 08:33:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> usr/klibc/arch/i386/libgcc/__ashldi3.S   |   29 +++++++
>> usr/klibc/arch/i386/libgcc/__ashrdi3.S   |   29 +++++++
>> usr/klibc/arch/i386/libgcc/__lshrdi3.S   |   29 +++++++
>> usr/klibc/arch/i386/libgcc/__muldi3.S    |   34 ++++++++
>> usr/klibc/arch/i386/libgcc/__negdi2.S    |   21 +++++
> 
> No divdi3?

The i386 ones are a bit special... usually the reason I have added 
libgcc functions is that on some architectures, gcc has various problems 
linking with libgcc in some configurations.  That is not the case on 
i386, but some of the libgcc functions are *way* bigger than the need to 
be (overall, the quality of code in libgcc seems horrid, across 
architectures.)

Since i386 is such an important architecture I added a handful of 
assembly functions for stuff that could be done in a very small amount 
of space.

	-hpa
