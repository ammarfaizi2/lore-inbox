Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135864AbRAMAzA>; Fri, 12 Jan 2001 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136012AbRAMAyv>; Fri, 12 Jan 2001 19:54:51 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:51361 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S135954AbRAMAyh>; Fri, 12 Jan 2001 19:54:37 -0500
Date: Sat, 13 Jan 2001 01:39:19 +0100
To: Wolfgang Spraul <wspraul@q-ag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0: ieee1394: got invalid ack 3 from node 65473 (tcode 4)
Message-ID: <20010113013919.A1321@storm.local>
Mail-Followup-To: Wolfgang Spraul <wspraul@q-ag.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <979098522.3a5bdb9aa7a72@ssl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <979098522.3a5bdb9aa7a72@ssl.local>; from wspraul@q-ag.de on Wed, Jan 10, 2001 at 04:48:42AM +0100
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 04:48:42AM +0100, Wolfgang Spraul wrote:
> Incompatibility with "Sarotech FHD-352F/U Rev 1.0"
> 
> Using an external IDE drive in the Sarotech FireWire enclosure fails, even
> though the Sarotech unit works with Win2K and other SBP2 drives work for me
> (with Linux).
> 
> I'm using 2.4.0 together with sbp2_1394_122300.tar.gz.
> ACK code 3 is not even mentioned in ieee1394.h.

That's because it's defined as reserved in the standard and therefore it
says "invalid ack".  The interesting would be whether we really get
that code or if there is a bug in the driver somewhere.

> I understand that the SBP2 driver is not (yet) included, but it will be shortly.
> Also, I guess the same problem applies to raw1394.o together with the Sarotech
> enclosure.

Could you test that with testlibraw?  (This program is built with libraw
and not installed currently.)

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
