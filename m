Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965970AbWKOHmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965970AbWKOHmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965992AbWKOHmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:42:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19166 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965970AbWKOHmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:42:12 -0500
Subject: Re: 2.6.19-rc5-mm2: warnings in MODPOST and later
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
In-Reply-To: <20061114150902.f772c75c.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114225622.GO22565@stusta.de>  <20061114150902.f772c75c.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 08:42:05 +0100
Message-Id: <1163576525.31358.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 15:09 -0800, Andrew Morton wrote:
> On Tue, 14 Nov 2006 23:56:22 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Since people were recently complaining about too many warnings:
> > Here is a list of the warnings I'm getting in MODPOST and later.
> > 
> > Since the warnings by far exceed the 100kB limit of linux-kernel (sic), 
> > I had to attach them compressed.
> > 
> > With the exception of the "drivers/ide/pci/atiixp:FFFF05", none of these 
> > warnings is present in Linus' tree.
> 
> yes, lots of new section mismatch warnings.
> 
> A large number of them are due to the paravirt patches:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458470) and '__stop_parainstructions'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458478) and '__stop_parainstructions'


ok this means that you shouldn't probably switch paravirtualizations
after boot, but that's ok ;) it's not like hypervisor support should be
a module anyway


