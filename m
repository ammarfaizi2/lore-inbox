Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136103AbRDVNJi>; Sun, 22 Apr 2001 09:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136102AbRDVNJ2>; Sun, 22 Apr 2001 09:09:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136101AbRDVNJJ>; Sun, 22 Apr 2001 09:09:09 -0400
Subject: Re: Linux 2.4.3-ac12
To: philb@gnu.org (Philip Blundell)
Date: Sun, 22 Apr 2001 14:10:41 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), junio@siamese.dhis.twinsun.com,
        manuel@mclure.org (Manuel McLure), linux-kernel@vger.kernel.org
In-Reply-To: <E14rJTP-0005jL-00@kings-cross.london.uk.eu.org> from "Philip Blundell" at Apr 22, 2001 02:00:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJdU-0005p0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you being deliberately obtuse?  2.97+ snapshots do all support 
> builtin_expect, which is what we were discussing.

I think we are having different conversations here.

The only valid inputs to the question are

	Recommended
	-----------
	egcs-1.1.2		(miscompiles strstr  <2.4.4pre)
	gcc 2.95.*		(miscompiles strstr  <2.4.4pre)

	Recommended (for -ac at least)
	------------------------------
	rh-gcc 2.96-69+		(DAC960 fails due to gcc ABI change)
	rh-gcc 2.96-78+

	For the Brave
	-------------
	gcc 3.0 snapshots

There are no gcc 2.97 snapshots that compile the kernel correctly because
they have the broken bitfield packing ABI change. 

So if your belief is that we should insist on gcc 3.0 for __builtin_expect
then we should simply remove use of it completely. For 2.5.x it will be worth
making heavy use of once gcc 3.0 is out.

My belief however is that several million people have gcc 2.96-69+, about 50
are likely to have random cvs snapshots and none of them are going to build
kernels with them anyway, as they wont work __builtin_expect or otherwise.

Alan

