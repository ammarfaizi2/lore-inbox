Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRDEOiI>; Thu, 5 Apr 2001 10:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbRDEOh6>; Thu, 5 Apr 2001 10:37:58 -0400
Received: from quasar.osc.edu ([192.148.249.15]:199 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S132908AbRDEOhn>;
	Thu, 5 Apr 2001 10:37:43 -0400
Date: Thu, 5 Apr 2001 10:36:41 -0400
From: Pete Wyckoff <pw@osc.edu>
To: John Weidman <johnw@believe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is jumbo ethernet MTU possible with Hamachi Gigabit ethernet driver?
Message-ID: <20010405103641.B11386@quasar.osc.edu>
In-Reply-To: <3ACBC361.CA701A2D@believe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i-nntp2
In-Reply-To: <3ACBC361.CA701A2D@believe.com>; from johnw@believe.com on Wed, Apr 04, 2001 at 05:59:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware also must support jumbo MTUs.  Hamachi limit is 1518 or
1522 (vlan) bytes, and the driver can't fix that.

		-- Pete

johnw@believe.com said:
> I'm trying to get some Gigabit ethernet cards that use the Packet
> Engines Hamachi GNIC-II chip to use a large mtu to attempt to get a
> throughput of close to the 1Gb rating of the card.  This is on a Compact
> PCI Alpha system.  I'm trying to use an MTU in the 8000 to 9000 range
> and so far have not been able to get these MTUs to work.
> 
> I have changed the PKT_BUF_SZ and MAX_FRAME_SIZE constants in hamachi.c
> and ETH_DATA_LEN and ETH_FRAME_LEN in if_ether.h.  I can use ifconfig to
> change the MTU above 1500 on one side of a connection but as soon as I
> raise the MTU on both sides to greater than 1500 the link dies.  I can
> change the MTU with ifconfig back to 1500 and the link will resume
> operation.  We are currently somewhat married to the 2.2.14 kernel.
> 
> I read that some ethernet drivers will support jumbo MTUs.  There
> appears to be something in the hamachi driver or the kernel that I've
> missed.  Perhaps this only works with a later version kernel or the
> hamachi driver needs more changes?  Any help would be appreciated.
