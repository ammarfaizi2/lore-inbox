Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310464AbSCGTNm>; Thu, 7 Mar 2002 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310467AbSCGTNd>; Thu, 7 Mar 2002 14:13:33 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:27908 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S310464AbSCGTNS>; Thu, 7 Mar 2002 14:13:18 -0500
Date: Thu, 7 Mar 2002 14:13:06 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: jgarzik@mandrakesoft.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
In-Reply-To: <20020306.141809.112819805.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0203071400080.3930-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, David S. Miller wrote:

> On sparc64 you should set the burst settings to 64-byte read/write
> bursts because the PCI chipset is going to disconnect you on 64-byte
> boundaries anyways.  If the chip is bursting more than this, you
> are wasting lots of PCI cycles with the retries done after the
> disconnect.

Ahh.. indeed, changing the burst size to 64 bytes (from the default 128)  
makes a big difference on my ultra5, thanks for the hint. Does it make any
sense to differentiate between platforms, or is 64 a good all-around
value?

> Also make sure to use PCI READ MULTIPLE commands for DMA if the chip
> provides such an option, this helps performance on many PCI
> controllers to no end.

MRM (and MRL) seem to be enabled by default, although the chip docs are a 
bit unclear about it.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

