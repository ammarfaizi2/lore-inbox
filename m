Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSC1AWY>; Wed, 27 Mar 2002 19:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310816AbSC1AWO>; Wed, 27 Mar 2002 19:22:14 -0500
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:24851 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S310769AbSC1AWD>;
	Wed, 27 Mar 2002 19:22:03 -0500
Date: Wed, 27 Mar 2002 17:21:24 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.19-pre4-ac2 hang at boot with ALI15x3 chipset support
Message-ID: <20020328002123.GA10950@archimedes>
Mail-Followup-To: James Mayer <james.mayer@acm.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020327233812.GA7310@galileo> <E16qNP7-0006T9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Message-Flag: Upgrade to Debian GNU/Linux, http://www.debian.org/
X-Uptime: 17:14:47 up 30 days,  6:02,  1 user,  load average: 0.71, 0.17, 0.06
From: James Mayer <james.mayer@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 12:04:33AM +0000, Alan Cox wrote:
> > After adding printk calls to alim15x3.c, it seems to hang during the
> > pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02) call on line 588.
> 
> Does it work if you comemtn that line out ?

No, if the line is commented out I get:

hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

 . . . and then the kernel panics because it can't find init.
