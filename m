Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSGFRgW>; Sat, 6 Jul 2002 13:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGFRgV>; Sat, 6 Jul 2002 13:36:21 -0400
Received: from www.transvirtual.com ([206.14.214.140]:4362 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315629AbSGFRgU>; Sat, 6 Jul 2002 13:36:20 -0400
Date: Sat, 6 Jul 2002 10:38:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25
In-Reply-To: <200207050047.30425.ivangurdiev@attbi.com>
Message-ID: <Pine.LNX.4.44.0207061036250.26054-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.5.25: 2 problems found
>
> 1) Options under Input Device Support and under Character Devices: Mice
> are duplicates from a user's point of view. Fortunately they have different
> names (CONFIG_PSMOUSE vs CONFIG_MOUSE_PS2).
> Unfortunately they both seem to be used...did a recursive grep.

The input api PS/2 mouse driver is meant to replace the old driver which
is in pc_keyb.c. Unfortunely most keyboard drivers are based around
pc_keyb.c so it has to stay for now. Plus the console system is designed
around pc_keyb.c. This will also change as the console system is migrated
toward the input api. So to any keyboard maintainers please port your
drivers over to the input api before they break when the console system
breaks.

