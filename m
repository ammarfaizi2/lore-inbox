Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267995AbTAHX56>; Wed, 8 Jan 2003 18:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267996AbTAHX56>; Wed, 8 Jan 2003 18:57:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267995AbTAHX55>; Wed, 8 Jan 2003 18:57:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
Date: 8 Jan 2003 16:06:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aviee3$2gs$1@cesium.transmeta.com>
References: <avi06f$89g$1@cesium.transmeta.com> <200301082123.h08LNXSY003383@darkstar.example.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200301082123.h08LNXSY003383@darkstar.example.net>
By author:    John Bradford <john@grabjohn.com>
In newsgroup: linux.dev.kernel
> 
> Shouldn't that part stay, incase somebody boots a machine from a
> floppy, and leaves it running for hours?
> 

No; interrupts are enabled so the BIOS will time out the floppy and
turn off the motor if necessary.  The only reason Linux (sort of)
needs that code is because the kernel takes control away from the
BIOS.  I say "sort of" because it really only matters if the kernel
doesn't have a floppy driver.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
