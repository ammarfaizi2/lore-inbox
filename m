Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbRDQPub>; Tue, 17 Apr 2001 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132733AbRDQPuV>; Tue, 17 Apr 2001 11:50:21 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:40915 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132732AbRDQPuG>; Tue, 17 Apr 2001 11:50:06 -0400
Date: Tue, 17 Apr 2001 17:50:03 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417175003.D2589096@informatics.muni.cz>
In-Reply-To: <20010417151007.F916@informatics.muni.cz> <20010417164103.A9515@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010417164103.A9515@gruyere.muc.suse.de>; from ak@suse.de on Tue, Apr 17, 2001 at 04:41:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
: On Tue, Apr 17, 2001 at 03:10:07PM +0200, Jan Kasprzak wrote:
: > 00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
: 
: IIRC the problem came up earlier. Some versions of 3com NICs seem to make
: problems with the hardware checksum. There were some fixes in the driver 
: later; could you try it with 2.4.4pre3 (which includes zerocopy) ?
: 
	I was not able to boot 2.4.4pre3 at all: It panicked when
initializing aic7xxx. So I've changed the config to old_aic7xxx,
but it locked up on starting up RAID arrays.

	BTW, patch-2.4.4pre3 does not contain any significant change
to 3c59x.c (the only change is adding some #include file).

	Now I am back to 2.4.3 and I'll try to run proftpd without sendfile().

-Y.

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
///... in B its 'extrn' not 'extern'.        Alan (yes I programmed in B)\\\

