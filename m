Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSL1UIl>; Sat, 28 Dec 2002 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSL1UIl>; Sat, 28 Dec 2002 15:08:41 -0500
Received: from host194.steeleye.com ([66.206.164.34]:41233 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265865AbSL1UIk>; Sat, 28 Dec 2002 15:08:40 -0500
Message-Id: <200212282016.gBSKGrF03354@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G 
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Sat, 28 Dec 2002 12:16:50 MST." <712898112.1041103010@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 14:16:53 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gibbs@scsiguy.com said:
> That hasn't applied since 6.2.10 or so.  2.5.X is still using 6.2.4. 

The bug report is against 2.5.53 which has 6.2.24 in it, so it still needs 
fixing.  At a cursory glance at the code, it looks like you don't call 
scsi_set_pci_device early enough in the detect routine.

James


