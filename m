Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSHQTMe>; Sat, 17 Aug 2002 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSHQTMe>; Sat, 17 Aug 2002 15:12:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5874 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318136AbSHQTMe>; Sat, 17 Aug 2002 15:12:34 -0400
Subject: Re: 2.4.20-pre2-ac3 stops responding
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <3D5D32D4.475C6719@wanadoo.fr>
References: <Pine.LNX.4.44L.0208161340000.1430-100000@imladris.surriel.com>
	 <3D5D32D4.475C6719@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 20:15:47 +0100
Message-Id: <1029611747.4647.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "On Fri, 2002-08-16 at 18:13, Jean-Luc Coulon wrote:
> At boot time, I get the messages :
> 
> Aug 16 11:34:19 f5ibh kernel: ALI15X3: simplex device: DMA disabled
> Aug 16 11:34:19 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
> (BIOS)

Linux did the simplex device check. Your ALi controller only permits DMA
on one of the devices at a time. What is attached to the ALi controller
? Also does 2.4.19 base enable DMA correctly ?

If so then my guess is there is a bug in the changing of the pci setup
code in 2.4.20pre2-ac3, which shouldnt be hard to figure out

