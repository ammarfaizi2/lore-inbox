Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268906AbRHBMWE>; Thu, 2 Aug 2001 08:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRHBMVy>; Thu, 2 Aug 2001 08:21:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268906AbRHBMVg>; Thu, 2 Aug 2001 08:21:36 -0400
Subject: Re: 3ware Escalade problems
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Thu, 2 Aug 2001 13:22:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ransom@cfa.harvard.edu (Scott Ransom),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010801185836.B22548@vger.timpanogas.org> from "Jeff V. Merkey" at Aug 01, 2001 06:58:36 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SHUV-0000SM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have an adapter, install it, dumop and gendisk head, and take a 
> look at what's happening.  I am seeing drives being reported with 0 
> block lengths and other wierdness.    

Looks fine to me. However if you are seeing 0 block length drives reported
thats tw_scsiop_read_capacity_complete() causing the sd.c code to do
something daft.

Alan
