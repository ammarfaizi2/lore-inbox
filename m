Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSCUUzW>; Thu, 21 Mar 2002 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312492AbSCUUzM>; Thu, 21 Mar 2002 15:55:12 -0500
Received: from port-212-202-185-53.reverse.qdsl-home.de ([212.202.185.53]:7697
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S312491AbSCUUy7>; Thu, 21 Mar 2002 15:54:59 -0500
Message-ID: <3C9A489D.DD8993C1@trash.net>
Date: Thu, 21 Mar 2002 21:54:53 +0100
From: Patrick McHardy <kaber@trash.net>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.4.18-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
CC: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Updated Equalize patch
In-Reply-To: <3C9A4270.56C09FCB@trash.net> <20020321203835.GT20420@sliepen.warande.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guus Sliepen schrieb:
> 
> On Thu, Mar 21, 2002 at 09:28:32PM +0100, Patrick McHardy wrote:
> 
> > I've updated the equalize patch to apply on 2.4.18.
> > The patch also addresses two race conditions in
> > ip_route_input(..) and ip_route_output_key(..).
> > The rt_hash_table entry is only read locked although elements
> > from the chain can be freed if there is a matching entry with
> > RTCF_EQUALIZE set.
> 
> Thank you very much! I've added it to the FTP site. I'd like to know if
> there is anything the patch does that can't be done with the bonding
> module, because otherwise I'd suggest using the latter (it's much
> cleaner and handles all Ethernet protocols).

You're welcome :)
I'm using it (better trying) to bond two ppp links together (actually
the
uplinks) without provider support by distributing the traffic according
to uplink bandwidth and spoofing source ip of link1 on link2.
I've not tried the bonding module but afaik it can't be used with ppp
links
and has to be supported by the other end so equalize looks like
the only way to do it, especially since i've got only very few high
bandwidth
connections and one link is a lot slower than the other so i can't rely
on
normal multipath routing to distribute traffic correct.

Bye,
Patrick
