Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263964AbTE3ULo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTE3ULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:11:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45322 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263964AbTE3ULn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:11:43 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: drivers/char/sysrq.c
Date: 30 May 2003 13:24:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bb8em9$f3j$1@cesium.transmeta.com>
References: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de> <20030530145851.GA15640@wohnheim.fh-wedel.de> <20030530151317.GA3973@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030530151317.GA3973@werewolf.able.es>
By author:    "J.A. Magallon" <jamagallon@able.es>
In newsgroup: linux.dev.kernel
> 
> I see a diff:
> - & is bitwise and you always perform the op
> - && is logical and gcc must shortcut it
> 
> I think people use & 'cause they prefer the extra argument calculation
> than the branch for the shortcut (AFAIR...)
> 
> or not ?
> 

In this case it doesn't matter, since gcc should be able to prove the
right-hand-side is side-effect free.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
