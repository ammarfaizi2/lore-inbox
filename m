Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSKRMaR>; Mon, 18 Nov 2002 07:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSKRMaR>; Mon, 18 Nov 2002 07:30:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28595 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261894AbSKRMaG>; Mon, 18 Nov 2002 07:30:06 -0500
Subject: Re: ALI 1533 / hang on boot / vaio c1mhp / 2.4.19 + acpi backport
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021118115232.GA553@paradigm.rfc822.org>
References: <20021117194745.GA1281@paradigm.rfc822.org>
	<1037573400.5356.1.camel@irongate.swansea.linux.org.uk> 
	<20021118115232.GA553@paradigm.rfc822.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Nov 2002 13:04:39 +0000
Message-Id: <1037624679.7503.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 11:52, Florian Lohoff wrote:
> It does - With acpi=off and acpi=off pci=biosirq (as mentioned in that
> crash). I also tried the somewhere mentioned UDMA66 force (ide0=ata66
> ide1=ata66) which does get over this point but fails to mount the root
> filesystem with IDE errors.

That woukd make sense. The ALI driver in 2.4.19 supports only ALi
north/south properly, not Ali/Transmeta or Ali/ATI combinations.
2.4.20-ac should get Ali/Transmeta right and 2.5.47-ac now has test code
to avoid non legacy DMA on the ATI

