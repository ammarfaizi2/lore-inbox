Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135432AbRDRW3m>; Wed, 18 Apr 2001 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135434AbRDRW3d>; Wed, 18 Apr 2001 18:29:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12044 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135432AbRDRW3Z>; Wed, 18 Apr 2001 18:29:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/pts question
Date: 18 Apr 2001 15:29:01 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bl4fd$amr$1@cesium.transmeta.com>
In-Reply-To: <01041822354404.00617@ElkOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <01041822354404.00617@ElkOS>
By author:    elko <elko@home.nl>
In newsgroup: linux.dev.kernel
> 
> as I understand, /dev/pts was created
> to make an end to the overload in /dev/<devices>
> and let the kernel put the entries in /dev/pts
> when they are used/needed/installed.
> 

You understand wrong.  /dev/pts was constructed because the semantics
of BSD pty's is broken (there are issues with permissions.)

> but still, when I enable /dev/pts, I have to
> keep the /dev/<devices> for backward compatibility
> with already installed applications that rely on them.

You should fix your applications.

> would it be possible/sane to make like a
> /dev/* (some sort of a /dev/B-compatible) besides
> /dev/pts, where the kernel `translates' the
> /dev/<device> request to /dev/* and then
> `translate' that to the correct /dev/pts entry ??

Absolutely not.  BSD and Unix98 ptys have different semantics, and
absolutely, positively, must be kept separate -- or you have a
security hole in your machine.

Fix your old applications.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
