Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUJKOon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUJKOon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJKOnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:43:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:26093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269015AbUJKOmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:42:13 -0400
Date: Mon, 11 Oct 2004 07:42:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
 <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Paul Mackerras wrote:
> 
> Are you using suspend-to-ram or suspend-to-disk?

Suspend-to-disk. suspend-to-ram still doesn't work for me (never has, oh,
well.. Slow progress).

> For now (i.e. 2.6.9), could we have the following patch?  It only
> affects suspend-to-disk, and it tells the drivers that we are going to
> D3cold (4) when we are doing suspend-to-disk.

No.

If we do this, then we don't need the translation at all. And I guarantee
you that drivers _will_ be broken - I had this in my tree earlier by
virtue of "no translation". I mentioned the tg3 driver already, and I
assume others will too.

I repeat: we can remove the hack if somebody checks the drivers. 

			Linus
