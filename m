Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBQLKE>; Mon, 17 Feb 2003 06:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBQLKE>; Mon, 17 Feb 2003 06:10:04 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:54508 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S266981AbTBQLKD>; Mon, 17 Feb 2003 06:10:03 -0500
From: Erik Hensema <usenet@hensema.net>
Subject: Re: Linux v2.5.61
Date: Mon, 17 Feb 2003 11:20:00 +0000 (UTC)
Message-ID: <slrnb51hav.6i0.usenet@bender.home.hensema.net>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com> <20030215135345.GA16783@merlin.emma.line.org> <87ptptx9z1.wl@ipinfusion.com> <1045389793.2068.39.camel@imladris.demon.co.uk>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse (dwmw2@infradead.org) wrote:
> On Sun, 2003-02-16 at 01:58, Kunihiro Ishiguro wrote:
>> >Well, the kernel doesn't link for me when IPV6 is compiled as a module (config
>> >below) -- linking IPv6 in is fine.
>> 
>> Here is a fix for xfrm6_get_type() link problem when IPv6 is
>> configured as a module.
> 
>> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> 
> No. Do not ever use #ifdef CONFIG_xxx_MODULE. You should be able to
> build modules later by adding them to your config.

IPv6 has been an exception to this rule for a long time. For at least the
entire 2.4.x series, you have to recompile the entire kernel when you
enable the IPv6 module.

And no, I'm not saying I like it ;-)

-- 
Erik Hensema <erik@hensema.net>
