Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310380AbSCGQGG>; Thu, 7 Mar 2002 11:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310374AbSCGQFx>; Thu, 7 Mar 2002 11:05:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310376AbSCGQFa>; Thu, 7 Mar 2002 11:05:30 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Thu, 7 Mar 2002 16:19:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), yodaiken@fsmlabs.com,
        jdike@karaya.com (Jeff Dike), bcrl@redhat.com (Benjamin LaHaise),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <E16izss-000390-00@starship.berlin> from "Daniel Phillips" at Mar 07, 2002 04:32:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j0by-0002lS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Higher order allocation - imho we can fix that too, eventually, however it's a lot
> more work.  First we have to have reliable physical defragmentation.
> 
> > And if we are OOM - we want to return NULL
> 
> What good does that do?

It allows us to continue. It avoids the deadlocks. It lets the caller
make an intelligent decision.

