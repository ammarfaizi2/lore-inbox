Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSHLJJj>; Mon, 12 Aug 2002 05:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHLJJj>; Mon, 12 Aug 2002 05:09:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21496 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317619AbSHLJJi>; Mon, 12 Aug 2002 05:09:38 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       julliard@winehq.com, ldb@ldb.ods.org
In-Reply-To: <Pine.LNX.4.44.0208121246340.2955-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121246340.2955-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 11:34:28 +0100
Message-Id: <1029148468.16421.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 11:49, Ingo Molnar wrote:
> but, couldnt APM use its own private GDT for real-mode calls, with 0x40
> filled in properly? That would pretty much decouple things.

That would get extremely messy when handing interrupts arriving while in
an APM bios call (which is required on many laptops). I believe the 0x40
= 0x40 assumption is identical across windows, buggy apm, buggy bios32,
buggy edd, buggy .. (you get the picture)

