Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRKALEB>; Thu, 1 Nov 2001 06:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278692AbRKALDv>; Thu, 1 Nov 2001 06:03:51 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:65298 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S278690AbRKALDj>;
	Thu, 1 Nov 2001 06:03:39 -0500
Message-ID: <20011101141111.A27180@castle.nmd.msu.ru>
Date: Thu, 1 Nov 2001 14:11:11 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Juergen Hasch <Hasch@t-online.de>
Cc: linux-kernel@vger.kernel.org,
        =?koi8-r?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>,
        J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <15yzpC-26N6dEC@fwd04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <15yzpC-26N6dEC@fwd04.sul.t-online.com>; from "Juergen Hasch" on Wed, Oct 31, 2001 at 07:10:49PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 07:10:49PM +0100, Juergen Hasch wrote:
> 
> I had some trouble with an Intel STL 2 board and the onboard EEPRO100.
> Samba worked OK but it always got stuck on NFS transfers.
> 
> There was a bug in the older BMC firmware, so the eepro100 detected
> some NFS frames as "TCO" packets.
> (http://support.intel.com/support/motherboards/server/ta_353-1.htm)
> 
> If you use the e100 driver, you can look at 
> /proc/net/PRO_LAN_ADAPTERS/eth0.info
> If the "Tx_TCO_Packets" entry isn't zero after NFS times out,
> this may be your problem.
> With the eepro100 driver you will only see overruns with ifconfig.

It should be Rx_TCO_Packets, not Tx.
The problem described in Intel's advisory is related to incorrect processing
of receiving packets.

	Andrey
