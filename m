Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSLITZs>; Mon, 9 Dec 2002 14:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLITZs>; Mon, 9 Dec 2002 14:25:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20741 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266042AbSLITZr>; Mon, 9 Dec 2002 14:25:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Date: 9 Dec 2002 11:33:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <at2r5v$fib$1@cesium.transmeta.com>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E18LBeK-00046y-00@calista.inka.de>
By author:    Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
In newsgroup: linux.dev.kernel
>
> In article <m3d6ocjd81.fsf@Janik.cz> you wrote:
> > this patch add support for four functions key on DELL Latitude X200.
> 
> we need a more generic appoach to handle those key codes for various
> extensions. I think a pure software reconfiguration of the keymaps or a
> daemon trakcing the raw codes is fine. Perhaps we can make something like a
> hook into the kernel where all untrapped function keys are send to in raw
> format?
> 

The PC only has so many possible keycodes (with E0 and E1 it's still
in the sub-300 range.)  It won't fit within 128, but I would really
like an algorithmic mapping from scancodes to keycodes so we don't
continue to have this problem.

For example, using a 16-bit keycode model:


	Scancode		Keycode (binary)
	mxxxxxxx	 	m0000000 0xxxxxxx
	E0 mxxxxxxx		m0000000 1xxxxxxx
	E1 mxxxxxxx yyyyyyyy	mxxxxxxx yyyyyyyy

m = make/break bit

	-hpa

	
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
