Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRACLXg>; Wed, 3 Jan 2001 06:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130077AbRACLX0>; Wed, 3 Jan 2001 06:23:26 -0500
Received: from Cantor.suse.de ([194.112.123.193]:64268 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129771AbRACLXK>;
	Wed, 3 Jan 2001 06:23:10 -0500
Date: Wed, 3 Jan 2001 11:52:36 +0100
From: Andi Kleen <ak@suse.de>
To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
Message-ID: <20010103115236.A29799@gruyere.muc.suse.de>
In-Reply-To: <14930.42496.545862.426153@notabene.cse.unsw.edu.au> <Pine.LNX.3.96.1010103082044.20347B-100000@latt.if.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010103082044.20347B-100000@latt.if.usp.br>; from delyra@latt.if.usp.br on Wed, Jan 03, 2001 at 08:37:08AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 08:37:08AM -0200, Jorge L. deLyra wrote:
> It would be nice if a way was found to implement this feature on knfsd.

There is: just run unfsd too, bound to an own IP address to not conflict. 

More efficient would probably be a proxy though that just forwards packets.
I see no reason in core NFS why multiple clients could not share a single 
multiplexed mount. It could need some lockd support though. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
