Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRBWJvW>; Fri, 23 Feb 2001 04:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWJvM>; Fri, 23 Feb 2001 04:51:12 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:42761 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130397AbRBWJu7>;
	Fri, 23 Feb 2001 04:50:59 -0500
Date: Fri, 23 Feb 2001 11:50:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels (fwd)
Message-ID: <20010223115020.A2622@suse.cz>
In-Reply-To: <20010222122055.A1278@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010222122055.A1278@iname.com>; from rbrito@iname.com on Thu, Feb 22, 2001 at 12:20:55PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 12:20:55PM -0300, Rogerio Brito wrote:

> 	This message was apparently intended to be sent to the list.
> 
> 
> 	[]s, Roger...
> 
> ----- Forwarded message from Pozsar Balazs <pozsy@sch.bme.hu> -----
> 
> From: Pozsar Balazs <pozsy@sch.bme.hu>
> To: Rogerio Brito <rbrito@iname.com>
> Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
> Date: Thu, 22 Feb 2001 01:04:27 +0100 (MET)
> Message-ID: <Pine.GSO.4.30.0102220103290.8797-100000@balu>
> 
> 
> The kernel doesn't seem to set 32bit io transfers by default. Is it
> dangerous or unrecommended to set it with hdparm?

It does:

via82cxxx.c, line 536: hwif->drives[i].io_32bit = 1;

Actually this seems to be required for correct operation in PIO modes.
Anyway, it doesn't have an effect if DMA/UDMA modes are used -
BusMastering is always 32bit.

-- 
Vojtech Pavlik
SuSE Labs
