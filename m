Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTIKO15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTIKO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:27:56 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35217 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261235AbTIKO10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:27:26 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030911062816.GX27368@fs.tum.de>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se>
	 <20030907174341.GA21260@mail.jlokier.co.uk>
	 <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
	 <20030911062816.GX27368@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063290309.2962.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 15:25:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 07:28, Adrian Bunk wrote:
> - Does the Cyrix III support 686 instructions?

Original Cyrix III supports the IA32 P6 definition
VIA C3 supports the IA32 P6 definition
The later ones also support cmov (the gcc i686 definition)

They run 486 scheduling better it seems because its a single issue
machine. Turn off the padding tho.

> - Do -march=winchip{2,-c6} and -march=c3{,-2} add anything not in
>   -march=i686 (except optimizations of otherwise compatible code)?

Its i586 ish (but runs best with 486 code kept compact as with the C3).
It lacks some bits of Pentium (lot of profiling, appendix H type stuff)
but is 586 + optional extras in other areas.

