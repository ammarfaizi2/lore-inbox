Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318590AbSHBLDI>; Fri, 2 Aug 2002 07:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSHBLDI>; Fri, 2 Aug 2002 07:03:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19446 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318590AbSHBLDH>; Fri, 2 Aug 2002 07:03:07 -0400
Subject: Re: Linux 2.5.30
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Banai Zoltan <bazooka@emitel.hu>, Alexander Viro <viro@math.psu.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208012015291.16391-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208012015291.16391-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 13:23:18 +0100
Message-Id: <1028290998.18309.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 04:17, Linus Torvalds wrote:
> If the PNP BIOS panic is new (ie it didn't happen in 2.5.24), can you
> write down the whole panic (and look up the symbols) and send that one to
> Ingo Molnar <mingo@elte.hu>?
> 
> That would most likely be due to some of the GDT reorganizations that
> happened for 2.5.30 due to the thread-local-storage patches.

The PnPBIOS gdt setup changes I did are wrong somewhere. If I can get
2.5.30 to actually boot I'll try and track it down. The traces I have
basically go 
	kernel -> kernel -> kernel -> pnpbios *BANG*

and appear to be jumping to the wrong physical address (ie gdt is
incorrect)

