Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbSLEVJ7>; Thu, 5 Dec 2002 16:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbSLEVJN>; Thu, 5 Dec 2002 16:09:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267429AbSLEVI7>; Thu, 5 Dec 2002 16:08:59 -0500
Message-ID: <3DEFC1E8.6070408@zytor.com>
Date: Thu, 05 Dec 2002 13:15:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
References: <p73u1l7qbxs.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com> <asgsir$p18$1@cesium.transmeta.com> <20021205105817.GC127@elf.ucw.cz>
In-Reply-To: <20021205105817.GC127@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>
>>While we're talking about printk()... is there any reason *not* to
>>rename it printf()?
> 
> I believe printf() is good idea. I put printk() into userland programs
> too many times now, and used printf() too many times from kernel.
 >

The only reason I can think of *not* to call it printf() is that you may 
want to do something for userspace testing like:

#define printk(X, Y...) fprintf(stderr, X, ## Y)

	-hpa


