Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSCICLO>; Fri, 8 Mar 2002 21:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292395AbSCICLE>; Fri, 8 Mar 2002 21:11:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47620 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292391AbSCICKu>; Fri, 8 Mar 2002 21:10:50 -0500
Subject: Re: PnP BIOS driver status
To: bgerst@didntduck.org (Brian Gerst)
Date: Sat, 9 Mar 2002 02:26:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jdthood@mail.com (Thomas Hood),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C896A97.7DA21DF9@didntduck.org> from "Brian Gerst" at Mar 08, 2002 08:51:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jWYf-0008Q4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The GDT descriptors are set up before /proc comes into being. I'm checking
> > 2.4 code here - has someone left old stuff in 2.5 ?
> 
> PNP_TS1 and PNP_TS2 are changed on every call to the bios to point to
> where the data for the 32-bit code lives.

Got you - yes Thomas he's absolutely right. The lock needs to be taken
by the callers before they set the PNP_TS* entries. 

