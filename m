Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUCaKvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 05:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCaKvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 05:51:17 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:42963 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261900AbUCaKvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 05:51:16 -0500
Date: Wed, 31 Mar 2004 12:51:14 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Piszcz <jpiszcz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.4 - APIC Errors
In-Reply-To: <Law10-F962yDX4WeD7800014ce0@hotmail.com>
Message-ID: <Pine.LNX.4.55.0403311245310.24584@jurand.ds.pg.gda.pl>
References: <Law10-F962yDX4WeD7800014ce0@hotmail.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Justin Piszcz wrote:

> Does anyone know what would cause these APIC errors?
> 
> # dmesg
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)
> APIC error on CPU0: 40(40)

 These (40) report an incorrect interrupt vector.  Do you ever see any
other values reported?  If not, then I'd suspect an APIC configuration 
error.  There are a few debug facilities in arch/i386/kernel/io_apic.c 
that can be used to investigate that.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
