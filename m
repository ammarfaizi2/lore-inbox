Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSHBNrM>; Fri, 2 Aug 2002 09:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSHBNrM>; Fri, 2 Aug 2002 09:47:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26376 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314277AbSHBNrK>;
	Fri, 2 Aug 2002 09:47:10 -0400
Date: Fri, 2 Aug 2002 14:50:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: gerg@snapgear.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.30uc0 MMU-less patches
Message-ID: <20020802145034.B24631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some constructive criticism...

 - the Makefile changes seem terribly inappropriate.
 - you probably didn't mean to include page_alloc2.hack in the diff

 - Do you really need your own copy of fbcon.c?  Can it be merged with the
   one in drivers/video?
 - arch/m68knommu/console/68328fb.c should probably move to drivers/video
   too.
 - ditto most of the other files in the console directory ... 

 - Why are the changes to rd.c required?
 - I'm not sure it's appropriate to include the changes to nfs2xdr.c --
   is this a toolchain bug you're working around?

 - drivers/char/mcfserial.c needs to be converted to the new serial core
   and moved to drivers/serial.
 - ditto arch/m68knommu/platform/68360/quicc/uart.c

I'll look at the change you want to make to locks.c - I'm not terribly
fond of that interaction either.

-- 
Revolutions do not require corporate support.
