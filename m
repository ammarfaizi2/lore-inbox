Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135766AbRDTAQZ>; Thu, 19 Apr 2001 20:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135764AbRDTAQH>; Thu, 19 Apr 2001 20:16:07 -0400
Received: from pop.gmx.net ([194.221.183.20]:44142 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135763AbRDTAPv>;
	Thu, 19 Apr 2001 20:15:51 -0400
Message-ID: <3ADF5A1A.CE914410@gmx.de>
Date: Thu, 19 Apr 2001 23:35:22 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Manfred Bartz <md-linux-kernel@logi.cc>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: Real Time Traffic Flow Measurement - anybody working on it?
In-Reply-To: <HBEEKENFCJOPCENEDAGHOEAECCAA.michael@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Michael Clark wrote:
> 
> An obvious kernel improvement for userspace meters like NeTraMet would
> be to give libpcap's pcap_read a kernel interface that can return more
> than one packet at a time (the libpcap interface has this capability).

It's already there - the turbo packet interface (PACKET_RX_RING sockopt).
Very nice and fast.  Direct transfer to mmapped memory.

> An additional feature for network devices that could support it (not
> sure if this is feasible) would be to switch to an 'interrupt when
> packet buffer full' when in promiscuous mode.

With the RX_RING you can poll a memory location in the mmapped memory
to detect whether there are new packets.  You basically only perform
a system call (poll/select) if there's nothing more to do.

Ciao, ET.

