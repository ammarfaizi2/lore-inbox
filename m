Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVHWNaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVHWNaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVHWNaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:30:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:3188 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932170AbVHWNav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:30:51 -0400
Date: Tue, 23 Aug 2005 15:30:50 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Rajesh <rvarada@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debug a high load average
Message-ID: <20050823133050.GC29062@harddisk-recovery.com>
References: <430B03B4.8040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B03B4.8040205@gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 04:38:36PM +0530, Rajesh wrote:
> I have a case occasionally when I copy data from a usb storage (ipod) to 
> my hard drive the load average goes up from 0.4 to about 15.0, and the 
> system becomes very unusable till I kill the cp command. I have checked 
> the CPU usage, bytes read from usb device, byte written to hard drive 
> etc, and all these values are low like CPU usage is at a maximum of 30%, 
> disk read bytes is at an average of 1.5 MiB/s, disk write bytes is at 
> 1.5 MiB/s, number of processes is at 110, etc, during this high load.

1.5 MB/s suggests you're using an IDE drive in PIO mode. Switch to DMA
mode (hdparm -d 1 /dev/hda) and see if it gets any better.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
