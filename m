Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVDCEJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDCEJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 23:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDCEJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 23:09:51 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:12933
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261454AbVDCEJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 23:09:28 -0500
Date: Sat, 2 Apr 2005 20:08:58 -0800
From: "David S. Miller" <davem@davemloft.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: matthew@wil.cx, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iomapping a big endian area
Message-Id: <20050402200858.37347bec.davem@davemloft.net>
In-Reply-To: <1112499639.5786.34.camel@mulgrave>
References: <1112475134.5786.29.camel@mulgrave>
	<20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	<20050402183805.20a0cf49.davem@davemloft.net>
	<20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	<1112499639.5786.34.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Apr 2005 21:40:39 -0600
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> After all, the driver must know the card is BE, so the routines that
> make use of the feature are easily coded into the card, so there's no
> real need to add it to the iomem cookie.

Yes, I don't believe it needs to be in the cookie either.

> Did anyone have a preference for the API?  I was thinking
> ioread32_native, but ioread32be is fine too.

I think doing foo{be,le}{8,16,32}() would be consistent with
our byteorder.h interface names.
