Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBBRRT>; Fri, 2 Feb 2001 12:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRBBRRK>; Fri, 2 Feb 2001 12:17:10 -0500
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:19717 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129258AbRBBRQ5>;
	Fri, 2 Feb 2001 12:16:57 -0500
Date: Fri, 2 Feb 2001 17:16:10 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel 2.4.1
Message-ID: <20010202171610.B344@kermit.wd21.co.uk>
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk> <E14ORB4-000571-00@the-village.bc.nu> <20010201220624.E340@kermit.wd21.co.uk> <001a01c08bf0$74c47d60$02c8a8c0@zeusinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <001a01c08bf0$74c47d60$02c8a8c0@zeusinc.com>; from ttsig@tuxyturvy.com on Thu, Feb 01, 2001 at 01:44:01 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Feb 2001 01:44:01 Tom Sightler wrote:

> My patches also include changes that should improve this, but I doubt it
> will eliminate the problem.  The basic thing here is that it's a horrid
> card
> in regards to performance and most of them only have 8K of buffer, it's
> just
> too easy to overrun the buffer, especially since the default is to
> allocate
> 4 transmit and 1 receive buffer (or 6 receive buffers it your lucky
> enough
> to have a 16K card).  Because of this the card drops packets like crazy,
> which is bad for NFS, especially over UDP.  My patches basically change
> the
> buffer allocation to only a single transmit buffer and whatever is left
> to
> receive buffers, this puts the card in a different mode of operation
> which
> seems to allow it to almost keep up.  For me, this made the card usable,
> I
> still get drops, but their now much lower.
> 
> I'm not sure this is your problem, but I bet if you look at you ifconfig
> stats when your having the problem you'll see lots of dropped packets.
> 
> Even if you don't use the card, it's be nice to have another user test it
> out before I submit the patch.

Yes, lot's of dropped packets during NFS dropout.

This is great, even though I probably won't use the card; My friend has
another 9585 and needs an ethernet card for that, and I'll be happy to test
it on his behalf.

My machine's working perfectly now... IBM PS/2 9585, 3Com 32529, Adaptec
AHA1640, Linux 2.4.1, a 9GB RAID0 array care of the md driver, and ReiserFS
running on top of that... filled with MP3's! (just testing...)

Look forward to your patches.

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
