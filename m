Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDDTEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDDTEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDDTEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:04:14 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:31461
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261333AbVDDTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:04:08 -0400
Date: Mon, 4 Apr 2005 12:03:04 -0700
From: "David S. Miller" <davem@davemloft.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dvrabel@arcom.com, benh@kernel.crashing.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org
Subject: Re: iomapping a big endian area
Message-Id: <20050404120304.5767b80f.davem@davemloft.net>
In-Reply-To: <1112641079.5813.70.camel@mulgrave>
References: <1112475134.5786.29.camel@mulgrave>
	<20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	<20050402183805.20a0cf49.davem@davemloft.net>
	<20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	<1112499639.5786.34.camel@mulgrave>
	<20050402200858.37347bec.davem@davemloft.net>
	<1112502477.5786.38.camel@mulgrave>
	<1112601039.26086.49.camel@gaston>
	<1112623143.5813.5.camel@mulgrave>
	<42516034.7000802@arcom.com>
	<1112641079.5813.70.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2005 13:57:59 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Mon, 2005-04-04 at 16:41 +0100, David Vrabel wrote:
> > The Network Processing Engines in the Intel IXP425 are big-endian and
> > its XScale core may be run in little-endian mode. There's a bunch of
> > gotchas related to running in little-endian mode so you typically run
> > the IXP425 in big-endian mode, though.
> 
> Yes, based on feedback from Mips people and others pointing out the
> existence of the motorola rapidio bus, which is BE, I give in and agree
> that the io{read,write}{16,32}be are the way to go.
> 
> How does the attached look?

This looks fine to me.
