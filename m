Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143380AbRA1OzF>; Sun, 28 Jan 2001 09:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143381AbRA1Oyz>; Sun, 28 Jan 2001 09:54:55 -0500
Received: from Cantor.suse.de ([194.112.123.193]:18956 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S143380AbRA1Oyi>;
	Sun, 28 Jan 2001 09:54:38 -0500
Date: Sun, 28 Jan 2001 15:54:36 +0100
From: Andi Kleen <ak@suse.de>
To: James Sutherland <jas88@cam.ac.uk>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010128155436.A13968@gruyere.muc.suse.de>
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sun, Jan 28, 2001 at 01:29:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:29:52PM +0000, James Sutherland wrote:
> > The internet is a form of organized chaos, sometimes you gotta make
> > these type of decisions to get things done. Imagine the joy _most_
> > people would get flogging all firewall admins who block all ICMP.
> 
> Blocking out ICMP doesn't bother me particularly. I know they should be
> selective, but it doesn't break anything essential.

Ever heard of path mtu discovery? For example you essentially blocked out 
most people behind IP tunnels from your site (at least those who do not
do MSS hacks) 

In addition to breaking pmtu disc (which is a real showstopper for many setups),
it also have some negative effects on your servers. For example when your
mail server is for some reason trying to contact an unreachable host to
deliver a mail it'll not notice except after having wasted lots of bandwidth
and resources trying to contact the host again and again, even when the ICMP
clearly tells that it won't work. 

-Andi (who would join into Miquel's flogging) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
