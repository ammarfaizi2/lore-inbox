Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTDYT1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTDYT1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:27:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263778AbTDYT1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:27:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: versioned filesystems in linux (was Re: kernel support for
Date: 25 Apr 2003 12:38:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8c2sh$tp0$1@cesium.transmeta.com>
References: <200304251618.h3PGINWP001520@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.53.0304251259300.6839@chaos> <200304251748.h3PHmjQd012895@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200304251748.h3PHmjQd012895@turing-police.cc.vt.edu>
By author:    Valdis.Kletnieks@vt.edu
In newsgroup: linux.dev.kernel
> 
> Of bigger concern is that the inter-block gap is only 0.5 (or maybe 0.75
> inches, the memories are dim ;) - and you need to be able to stop and then get
> back up to speed in that distance (or decelerate, rewind, and get a running
> start).
> 

No, you don't.  You just need to make sure you don't have the head
active while you overshoot.  Performance will *definitely* suffer if
you don't, though, since you'd have to rewind.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
