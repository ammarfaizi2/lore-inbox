Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDPKyy>; Mon, 16 Apr 2001 06:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRDPKyp>; Mon, 16 Apr 2001 06:54:45 -0400
Received: from zmailer.org ([194.252.70.162]:14610 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130487AbRDPKy1>;
	Mon, 16 Apr 2001 06:54:27 -0400
Date: Mon, 16 Apr 2001 13:54:18 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: umam@delhi.tcs.co.in
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VRRP related
Message-ID: <20010416135418.B805@mea-ext.zmailer.org>
In-Reply-To: <3ADAFC74.3905C4D3@delhi.tcs.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ADAFC74.3905C4D3@delhi.tcs.co.in>; from umam@delhi.tcs.co.in on Mon, Apr 16, 2001 at 03:06:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	More to the topic list for future questions of this type is
	linux-net@vger.kernel.org  (or  netdev@oss.sgi.com -- real
	DEVELOPMENT talk goes there), but do read on.

On Mon, Apr 16, 2001 at 03:06:44PM +0100, umam@delhi.tcs.co.in wrote:
> Hi,
> I am trying to put virtual mac address at the place of physical mac
> address , for that I have overwrite source hardware address with virtual
> address.Now when I try to ping to this machine with some other
> machine.It says request time out.While checking arp -a , gives me
> virtual mac address in ARP-Table instead of physical mac address.I want
> it should give response to ping  also.what I can do????

	You will, probably, need to run the VRRPed interface port
	in PROMISCUOUS mode, or use multicast address for the MAC-
	address, and process reception of that correctly.

	There probably are more problems at using the multicast
	MAC address, than turning the interface into promiscuous.
	(At least the Linux packet reception path treats MC MAC
	 destined packets specially.)

	ARP request gets in because it is MAC-level broadcast.
 
> thanks

/Matti Aarnio
