Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269148AbRHBVAP>; Thu, 2 Aug 2001 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269157AbRHBVAM>; Thu, 2 Aug 2001 17:00:12 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24572 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269154AbRHBU7w>; Thu, 2 Aug 2001 16:59:52 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108022057.f72KvoQ9027818@webber.adilger.int>
Subject: Re: [PATCH] vxfs fix
In-Reply-To: <E15SOL6-0001JZ-00@the-village.bc.nu> "from Alan Cox at Aug 2, 2001
 08:41:00 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 2 Aug 2001 14:57:49 -0600 (MDT)
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hch@caldera.de,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:
> When the read_super method is invoked
> AND we are doing a mount without a defined type
> 	THEN
> 		Pass the fs a flag from the VFS saying so
> 	ENDIF
> 
> That way the file system can actually say "I cannot reliably check"

Isn't this what the "silent" option to read_super is for?  It may be that
it can only be used at root fs mount time.  Other than that, I don't
_think_ the kernel does autoprobing of filesystem types, so it is a
mount(8) issue to just not randomly try the V7 filesystem type.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

