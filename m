Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267848AbTAHSrS>; Wed, 8 Jan 2003 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbTAHSrS>; Wed, 8 Jan 2003 13:47:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51730 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267848AbTAHSrR>; Wed, 8 Jan 2003 13:47:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch(2.5.54): devfs shrink - integration candidate
Date: 8 Jan 2003 10:55:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avhs7l$qnc$1@cesium.transmeta.com>
References: <20030105201413.A10685@adam.yggdrasil.com> <20030105203725.A10808@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030105203725.A10808@adam.yggdrasil.com>
By author:    "Adam J. Richter" <adam@yggdrasil.com>
In newsgroup: linux.dev.kernel
> 
> 	This patch reduces include/linux/devfs*.h and fs/devfs from
> 3655 lines to 1239, a reduction of 2450 lines, nearly a factor three.
> That may not be as impressive as the original 5X reduction, but that
> is mostly because I've restored a bunch of functionality that I hope
> to eliminate in the future.
> 

Do we have any idea what the impact of this is on runtime data size?
I seem to remember devfs playing lots of tricks to reduce its working
set.  If this code size reduction ends up pinning large data
structures like dentries and inodes which wouldn't otherwise have been
pinned, this could be a significant lose.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
