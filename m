Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317757AbSFSDpk>; Tue, 18 Jun 2002 23:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317758AbSFSDpj>; Tue, 18 Jun 2002 23:45:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317757AbSFSDpi>; Tue, 18 Jun 2002 23:45:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: 2.5.x: arch/i386/kernel/cpu
Date: 18 Jun 2002 20:45:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aeouoe$a66$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whomever broke up arch/i386/kernel/setup.c and created the CPU
directory (very good idea) messed up in at least one place:

The *AMD-defined* CPUID flags (0x80000001) are not just used on AMD
processors!  In fact, at least AMD, Transmeta, Cyrix and VIA all use
them; I don't know about Centaur or Rise.  Intel supports the actual
level starting with the P4 although it returns all zero.

It should, in my opinion, be moved into generic_identify().  Anyone
who has a reason why that shouldn't be done speak now or I'll send the
patch to Linus.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
