Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSGNOPw>; Sun, 14 Jul 2002 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSGNOPv>; Sun, 14 Jul 2002 10:15:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1523 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316712AbSGNOPu>; Sun, 14 Jul 2002 10:15:50 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207141407.g6EE7fcL019119@burner.fokus.gmd.de>
References: <200207141407.g6EE7fcL019119@burner.fokus.gmd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 16:28:02 +0100
Message-Id: <1026660482.13886.51.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 15:07, Joerg Schilling wrote:
> >From alan@lxorguk.ukuu.org.uk Fri Jul 12 22:22:45 2002

> >There are lots that fudge around and pretend scsi is the block layer
> >when it is not. That sort of misses the point and slows down high end
> >raid cards.
> 
> It seems that you miss to understand the needed underlying driver structures.
> SCSI is not a block layer, it is a generic transport.

It is not generic - its handling of sophisticated I/O stuff is non
existant. SCSI gave rise to a convenient command set for low end devices
thats since been applied (with endless problems due to its use) to
things like fibrechannel.

Of course if you'd actually bothered to read the code (as I told you to
go do a while back) you might understand the 2.5 direction with the
block I/O layers. Using scsi command sets as a driver abstraction is a
nonsense, its incomplete, inefficient and too full of messy rules that
its not reasonable to inflict on hardware that doesn't care (eg recovery
from tagged command sequences on an error from the drive). 2.5 has a
much much saner abstraction thank you.



Alan

