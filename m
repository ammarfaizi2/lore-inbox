Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUHKFzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUHKFzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUHKFzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:55:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267946AbUHKFzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:55:38 -0400
Date: Tue, 10 Aug 2004 22:55:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: us15@os.inf.tu-dresden.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
Message-Id: <20040810225501.1fb803a2.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 22:13:01 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I also wonder what the 
> hell is allocating so many 8kB and 32kB entries.

Loopback default MTU is 16K these days, might explain
the 32K entries but not the 8KB ones.  Perhaps the
later are being used for page tables?  Just a guess
on that latter one.
