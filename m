Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTDPQiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTDPQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:37:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264449AbTDPQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:36:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] kdevt-diff
Date: 16 Apr 2003 09:48:16 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7k1gg$6uc$1@cesium.transmeta.com>
References: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl> <20030414221110.GK4917@ca-server1.us.oracle.com> <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu>
By author:    Valdis.Kletnieks@vt.edu
In newsgroup: linux.dev.kernel
>
> --==_Exmh_-1812532000P
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, 14 Apr 2003 15:11:10 PDT, Joel Becker said:
> 
> > 	I guess I'm wondering what made you choose "consistency across
> > legacy filesystems" over "consistency across our expanded device space".
> 
> I'm going to take a wild stab in the dark and say that being able to
> boot using the /dev on an iso9660 CD is a requirement for most distros?
> 

Not really, but it's certainly a nice capability.  However, iso9660
(RockRidge, actually) has 64 bits of dev_t space; it's actually split
into two 32-bit entries specified as "high 32 bits" and "low 32 bits."

I'm not positive if Linux expects those to contain major:minor or
0:<16-bit-dev_t>.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
