Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSIIOx3>; Mon, 9 Sep 2002 10:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSIIOx3>; Mon, 9 Sep 2002 10:53:29 -0400
Received: from host194.steeleye.com ([216.33.1.194]:22285 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317329AbSIIOx2>; Mon, 9 Sep 2002 10:53:28 -0400
Message-Id: <200209091458.g89Evv806056@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Lars Marowsky-Bree <lmb@suse.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Sep 2002 09:57:56 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> said:
> So, what is the take on "multi-path IO" (in particular, storage) in
> 2.5/2.6?

I've already made my views on this fairly clear (at least from the SCSI stack 
standpoint):

- multi-path inside the low level drivers (like qla2x00) is wrong
- multi-path inside the SCSI mid-layer is probably wrong
- from the generic block layer on up, I hold no specific preferences

That being said, I'm not particularly happy to have the multi-path solution 
tied to a specific raid driver; I'd much rather it were in something generic 
that could be made use of by all raid drivers (and yes, I do see the LVM2 
device mapper as more hopeful than md in this regard).

> I am looking at what to do for 2.5. I have considered porting the
> small changes from 2.4 to md 2.5. The LVM1 changes are probably and
> out gone, as LVM1 doesn't work still.

Well, neither of the people most involved in the development (that's Neil 
Brown for md in general and Ingo Molnar for the multi-path enhancements) made 
any comments---see if you can elicit some feedback from either of them.

James


