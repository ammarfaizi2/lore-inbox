Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSASV7K>; Sat, 19 Jan 2002 16:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSASV7B>; Sat, 19 Jan 2002 16:59:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15635 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287532AbSASV6l>; Sat, 19 Jan 2002 16:58:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [question] implentation of smb-browsing: kernel space or user space?
Date: 19 Jan 2002 13:58:31 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2cq67$2dq$1@cesium.transmeta.com>
In-Reply-To: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
By author:    Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
In newsgroup: linux.dev.kernel
> 
> My question is: Do you think, that this kind of filesystem is sensible, or do 
> you think that smb-stuff has to be in user space. (for example using the 
> filesystem in userspace approach, shown some weeks ago)?
> 

It REALLY should be in user space.  Putting this kind of crap in the
kernel is insane.  Note also that *browsing* (network 'hood) is
different from *mounting* -- even on Windows it is very common that
there are computers you can't see in your browse windows that you can
access by name.

Consider DNS -- it *used* to be possible to enumerate DNS (these days,
most servers will deny access to you if you try), but it has been a
long, long time since it was ever practical.  However, you can do
blind resolution quite trivially.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
