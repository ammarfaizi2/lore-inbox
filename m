Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSFXGo2>; Mon, 24 Jun 2002 02:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSFXGo2>; Mon, 24 Jun 2002 02:44:28 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:46280 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317023AbSFXGoZ>; Mon, 24 Jun 2002 02:44:25 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Nick Bellinger <nickb@attheoffice.org>
Subject: Re: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map)
Date: Mon, 24 Jun 2002 16:41:35 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
References: <59885C5E3098D511AD690002A5072D3C02AB7F52@orsmsx111.jf.intel.com> <1024895928.12662.192.camel@subjeKt>
In-Reply-To: <1024895928.12662.192.camel@subjeKt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206241641.35604.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002 15:18, Nick Bellinger wrote:
> This is a red herring,  what exactly is the definition of physically
> hooked up to the computer?  In the above context it comes out as being a
> device inside the machine or within close proximity (ie: USB, IEEE 1394,
> etc) and connected by a physical cable.  If this is the case then what
> becomes of an Fibre Channel array 10km removed?  What makes this more or
> less likely to be in driverfs than a IP storage array that is
> "physically connected" via gigabit ethernet cable in the next room?  If
> you where getting at devices which use the IP stack exclusively, then
> how do iSCSI HBAs with TCP offload engines fit into the mix?  The only
> scenario where I see the above statement holding true is if one was to
> use iSCSI over a wireless/radio link, then it most definitely could NOT
> be part of driverfs. :)
I think if you are mounting the remote filesystem (or otherwise using it in 
some stateful way), then it appears in driverfs at mount time. This is 
because it becomes important at that point - you now have a dependency on the 
underlying transport (the PCI bus better not be shut down before I get the 
dirty pages out over the network card to the storage array).

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
