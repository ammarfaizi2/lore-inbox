Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFGAW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFGAW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:22:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62481 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262413AbTFGAWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:22:25 -0400
Date: Fri, 6 Jun 2003 17:35:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert White <rwhite@casabyte.com>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, <davem@redhat.com>,
       <bcollins@debian.org>, <wli@holomorphy.com>, <tom_gall@vnet.ibm.com>,
       <anton@samba.org>
Subject: RE: /proc/bus/pci
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGEELACOAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.44.0306061730380.31112-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jun 2003, Robert White wrote:
> 
> So, my heard groans for another "domain" in the computer, and I like the way
> bridge reads

"bridge" means something completely different in PCI, it's a hub inside a 
PCI domain, literally "bridging" two separate parts of the same domain 
more-or-less seamlessly together. 

A PCI domain, in contrast, is something that is _not_ bridged to another
PCI domain - two PCI domains are disjunct, and do not share any connection
(PCI-wise) to each other.

(Obviously there is some _non_PCI connection, since they are in the same 
box, but that non-PCI connection might be the CPU, or it might be some 
other switching fabric that is not itself visible in the PCI space).

This is why "domain" makes sense - at least to me "domain" is a
independent area as in "I am the master of my domain", correctly implying
that there may be other domains, but that they are separate.

			Linus

