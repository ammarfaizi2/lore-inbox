Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWGDWrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGDWrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWGDWrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:47:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:3264 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932341AbWGDWrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:47:03 -0400
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: "'Vitaly Bordug'" <vbordug@ru.mvista.com>,
       "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 08:39:40 +1000
Message-Id: <1152052780.13828.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is that we don't have this PPC_UBDG_16550 option configurable now,
> and it is only made by default for several boards including pseries, chrp, prep, cell,
> and all 83xx and 85xx platforms.  If we need to change the whole thing, how should we do it?

It's up to your platformn code to enable it though. udbg will only kick
in from the legacy serial console code if your firmware indicates that
stdout is on a serial port. If the firmware doesn't, udbg won't kick in.
But yeah, build it in by default if you want then.

Ben.



