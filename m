Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSHMQRz>; Tue, 13 Aug 2002 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSHMQRz>; Tue, 13 Aug 2002 12:17:55 -0400
Received: from host194.steeleye.com ([216.33.1.194]:30474 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318240AbSHMQRx>; Tue, 13 Aug 2002 12:17:53 -0400
Message-Id: <200208131621.g7DGLc202919@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1 
In-Reply-To: Message from "Randy.Dunlap" <rddunlap@osdl.org> 
   of "Tue, 13 Aug 2002 08:48:28 PDT." <Pine.LNX.4.33L2.0208130847380.5175-100000@dragon.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 11:21:38 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rddunlap@osdl.org said:
> and that's precisely the wrong attitude IMO.

I wasn't expressing an opinion, just stating what could and could not be done 
in 2.4.

> I was glad to see that Marcelo asked about the hardcoded values. They
> hurt. 

Well, this is a rather big and particularly rancid can of worms.  If you look 
a little further, you'll see that cdrom.h has its own definition of the 
(effectively SCSI) struct request_sense that sr.c uses, yet the sense key is 
defined in scsi/scsi.h.  Then you notice that cdrom.h also duplicates all of 
the scsi commands with a GPCMD_ prefix.

If you'd like to take this particular can of worms off somewhere, clean it out 
and return it neatly labelled, I'd be more than grateful...just don't take the 
lid off too close to me.

James


