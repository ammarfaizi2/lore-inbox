Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSKRRBA>; Mon, 18 Nov 2002 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSKRRBA>; Mon, 18 Nov 2002 12:01:00 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24501 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263326AbSKRRA7>; Mon, 18 Nov 2002 12:00:59 -0500
Subject: Re: pnpbios oops on boot w/ 2.5.47
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: Andrew Morton <akpm@digeo.com>, Justin A <ja6447@albany.edu>,
       greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021117173443.GB1273@neo.rr.com>
References: <200211161700.29653.ja6447@albany.edu>
	<3DD6C1DC.44966373@digeo.com> <3DD6F655.4214A594@digeo.com>
	<20021116232528.GA1273@neo.rr.com> <3DD71CAA.E2FE9D9@digeo.com> 
	<20021117173443.GB1273@neo.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Nov 2002 17:35:15 +0000
Message-Id: <1037640915.7547.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one other problem. The pnp layer is initialized way
too early. I've moved pnpbios and isapnp to init after acpi and pci in
my tree and at least one weird oops on Telsa's Cyrix MediaGX + CS5520
box has gone away.

Now to figure out how I broke IDE ;)

