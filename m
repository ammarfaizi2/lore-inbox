Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290834AbSARVYB>; Fri, 18 Jan 2002 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290833AbSARVXv>; Fri, 18 Jan 2002 16:23:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38154 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290831AbSARVXj>; Fri, 18 Jan 2002 16:23:39 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Fri, 18 Jan 2002 21:35:19 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <OFFBBD700A.BEBAFED6-ON85256B44.00724FEA@raleigh.ibm.com> from "Kent E Yoder" at Jan 18, 2002 02:52:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RgfP-0007xJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   For #6, the udelay(1) had more to do with the following write() than 
> with spin_lock().  When that delay was not there, the write failed 
> randomly. The same with the udelay(10) at the end of the interrupt 
> function...

That smells of covering up a race rather than fixing something. Another
thing you may be doing perhaps is hiding PCI posting effects ?

Alan
