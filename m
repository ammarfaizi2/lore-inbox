Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269846AbRHIPaR>; Thu, 9 Aug 2001 11:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269844AbRHIPaI>; Thu, 9 Aug 2001 11:30:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:58616 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269843AbRHIP3v>; Thu, 9 Aug 2001 11:29:51 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108091529.f79FTNsc023173@webber.adilger.int>
Subject: Re: summary Re: encrypted swap
In-Reply-To: <9kt5hh$8fo$1@abraham.cs.berkeley.edu> "from David Wagner at Aug
 9, 2001 05:02:41 am"
To: David Wagner <daw@mozart.cs.berkeley.edu>
Date: Thu, 9 Aug 2001 09:29:23 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
> I keep giving examples where encrypted swap can still be useful even
> (or especially) when there is a risk that an attacker might gain access
> to the machine occasionally.  I like to think my examples should
> have been pretty clear, but if not, please ask, and I'll be happy to
> elaborate on whichever point you found unclear.

Another interesting use for encrypted swap - if you use it in conjunction
with tmpfs, then _many_ of the files in /tmp will never even be written
to disk (closing another potential security hole), but those that do get
written will be encrypted by swap (so are also safer).

Finally, there is the related issue of "diskless" machines, which have
swap and /tmp on a local disk (for improved performance/reduced network
overhead), and everything else is over the network.  I know many banks
run this way, so stealing one of these systems would not compromise
data if swap is encrypted.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

