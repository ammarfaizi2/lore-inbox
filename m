Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbRENJr3>; Mon, 14 May 2001 05:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbRENJrJ>; Mon, 14 May 2001 05:47:09 -0400
Received: from ns.suse.de ([213.95.15.193]:47629 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262276AbRENJrC>;
	Mon, 14 May 2001 05:47:02 -0400
Date: Mon, 14 May 2001 11:46:24 +0200
From: Andi Kleen <ak@suse.de>
To: root <root@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 3c590 vs. tulip
Message-ID: <20010514114624.A25364@gruyere.muc.suse.de>
In-Reply-To: <200105140809.f4E89qO11455@norma.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105140809.f4E89qO11455@norma.kjist.ac.kr>; from root@norma.kjist.ac.kr on Mon, May 14, 2001 at 05:09:52PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 05:09:52PM +0900, root wrote:
> Basically, it appears that Don Becker praised the Tulip chipset the most.  
> How much important is "zero copy TX and hardware checksumming"?

Zero copy TX is not that important yet except if you use samba or Tux or
proftpd or anything else that uses sendfile, but RX hardware checksumming 
is important as it saves a lot of CPU during receiving big packets. 
2.4 can in some circumstances do the checksumming during a copy (see 
netstat -s TCPHPHitsToUser), but hardware checksum is still preferable.
2.2 benefits from it more. 

The document seems to be rather outdated BTW, even boomerang is an 
old 3com chipset. Please not that the 4byte receive restriction on Tulip
also hurts i386. 

-Andi
