Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTFCOcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFCOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:32:04 -0400
Received: from [212.18.235.100] ([212.18.235.100]:12295 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S265029AbTFCOcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:32:03 -0400
Subject: Re: siimage driver status
From: Justin Cormack <justin@street-vision.com>
To: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu>
References: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 03 Jun 2003 15:45:41 +0100
Message-Id: <1054651541.17709.169.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 15:11, Wm. Josiah Erikson wrote:
> I have two drives (WD Raptors) on my A7N8X. I don't see any errors, even 
> after writing 9GB of data to the drive (after I've done an hdparm -X66 
> -d1 /dev/hd[x]), but it still boots up in pio mode. 
> Is there some silly hack I can do to the driver code to force all devices 
> to DMA on bootup? Everything works fine except for that. I'm using 
> 2.4.21-rc6-ac1
> Thanks!
> 	-Josiah
> 
> 
> This issue was reported by at least 3 People here on the list (including 
> me) with different 21-rcX kernels. Seems noone really cared :-(
> 
> I hope, this issue now get's addressed.
> btw. I could speed up my Transfer-Rate from 1.7MB/s to 55MB/s by setting
> hdparm -d1 -X66 on my two native SATA-Drives.

I think people care. Andre said he was working on a fix for the Seagate
drives some time back. It does seem that all BIOSs leave SATA drives in
PIO mode. That may be a bios bug really rather than a linux bug. But if
you put the hdparm somewhere early in boot you should be ok, as a
temporary workaround.


