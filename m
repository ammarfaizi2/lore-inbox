Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262827AbREVVUH>; Tue, 22 May 2001 17:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbREVVTw>; Tue, 22 May 2001 17:19:52 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:31493 "EHLO
	moisil.badula.org") by vger.kernel.org with ESMTP
	id <S262827AbREVVSs>; Tue, 22 May 2001 17:18:48 -0400
Date: Tue, 22 May 2001 14:18:28 -0700
Message-Id: <200105222118.f4MLISL01588@moisil.badula.org>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, dax@gurulabs.com (Dax Kelson)
Subject: Re: Xircom RealPort versus 3COM 3C3FEM656C
In-Reply-To: <E152HYH-0002LB-00@the-village.bc.nu>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001 20:10:41 +0100 (BST), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Before you give up on the xircom thing, try the -ac kernel and set the box
> up to use xircom_cb not xircom_tulip_cb
> 
> That might help a lot

It doesn't, it still performs poorly with any of the three available
drivers -- xircom_cb, xircom_tulip_cb, and tulip_cb (from the pcmcia package):

* Rx gets only about 1.8Mbit/s on a 100Base-TX network with any of the three
* Tx gets 80+Mb/s with xircom_tulip_cb and tulip_cb, and less than 30Mb/s
  with xircom_cb.

And no, promisc mode played no role in this experiment, because my test
network is switched and otherwise very quiet.

Windows drivers handle both Rx and Tx at full speed.

I have this feeling that we're handling the card in some (tulip) compat
mode, which severely cripples performance. It's hard to tell, without
docs...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
