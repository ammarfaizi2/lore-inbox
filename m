Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVD1Hb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVD1Hb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVD1Hb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:31:27 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:8616
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261982AbVD1HbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:31:19 -0400
Date: Thu, 28 Apr 2005 00:22:09 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, bjorn.helgaas@hp.com,
       davem@redhat.com
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-Id: <20050428002209.12bd3f37.davem@davemloft.net>
In-Reply-To: <1114672880.7111.254.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
	<20050426163042.GE2612@colo.lackof.org>
	<1114555655.7183.81.camel@gaston>
	<1114643616.7183.183.camel@gaston>
	<20050428053311.GH21784@colo.lackof.org>
	<20050427223702.21051afc.davem@davemloft.net>
	<1114670353.7182.246.camel@gaston>
	<20050427235056.0bd09a94.davem@davemloft.net>
	<1114672880.7111.254.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 17:21:19 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I have a real net big performance improvement on X by doing that
> trick ... the sysfs mmap API doesn't really provide a mean to do
> it explicitely from userland (unlike the ioctl with the old proc api)

You can refine your test to "if PCI class is display or VGA" and the
prefetchability is set in the BAR, then elide the guard PTE
protection bit.
