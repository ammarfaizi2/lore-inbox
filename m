Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUHDX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUHDX3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHDX3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:29:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267505AbUHDX3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:29:11 -0400
Date: Wed, 4 Aug 2004 16:26:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-Id: <20040804162652.52213d04.davem@redhat.com>
In-Reply-To: <20040804232116.GA30152@muc.de>
References: <2ppN4-1wi-11@gated-at.bofh.it>
	<2pvps-5xO-33@gated-at.bofh.it>
	<2pvz2-5Lf-19@gated-at.bofh.it>
	<2pwbQ-68b-43@gated-at.bofh.it>
	<m33c32ke3f.fsf@averell.firstfloor.org>
	<20040804191850.GA19224@havoc.gtf.org>
	<20040804122254.3d52c2d4.davem@redhat.com>
	<20040804232116.GA30152@muc.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2004 01:21:16 +0200
Andi Kleen <ak@muc.de> wrote:

> And it's pretty much unfixable because netlink is so adverse
> to emulation layers.

It is doable with is_compat_task() but you were against that.
That's unfortunate, since is_compat_task() provides a neat
solution for things like the USB device fs async stuff (ie.
so 32-bit libusb would work on 64-bit systems)
