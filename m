Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbRAXU5H>; Wed, 24 Jan 2001 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAXU45>; Wed, 24 Jan 2001 15:56:57 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34828 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131434AbRAXU4l>;
	Wed, 24 Jan 2001 15:56:41 -0500
Date: Wed, 24 Jan 2001 21:56:34 +0100
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Manfred Spraul <manfred@colorfullife.COM>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010124215634.A2992@gruyere.muc.suse.de>
In-Reply-To: <3A6E02E6.B3261E1@colorfullife.com> <200101242003.XAA21040@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101242003.XAA21040@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Wed, Jan 24, 2001 at 11:03:34PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 11:03:34PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > I read through the tcpdump, and it seems that Linux completely ignores
> > packets with out-of-window sequence numbers:
> 
> Yes, Linux is __very__ not right doing this. RFC requires to accept
> ACK, URG and RST on any segment adjacent to window, even if window
> is zero.

It's mostly for security to make it more difficult to nuke connections
without knowing the sequence number.

Remember RFC is from a very different internet with much less DoS attacks.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
