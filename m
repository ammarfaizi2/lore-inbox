Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWACR4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWACR4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWACR4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:56:22 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:54699 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S932478AbWACR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:56:21 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Using Intel ICH5 IDE+SATA Under 2.6.15-rc6 - Cannot find DVD-RW?
Date: Thu, 29 Dec 2005 14:38:14 -0800
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
References: <Pine.LNX.4.64.0512241837120.2700@p34> <Pine.LNX.4.64.0512241937230.5009@p34> <Pine.LNX.4.64.0512242017100.2335@p34>
In-Reply-To: <Pine.LNX.4.64.0512242017100.2335@p34>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512291438.14810.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 24, 2005 5:18 pm, Justin Piszcz wrote:
> SUMMARY:
>
> The libata=1 option is if you use "AUTO" in the bios, then it sees it
> but you can't (or I couldn't do anything with it anyway)
>
> scsi1 : ata_piix
>    Vendor: _NEC      Model: DVD_RW ND-3520A   Rev: 1.04
>    Type:   CD-ROM                             ANSI SCSI revision: 05
>
> I googled around and then found setting it to Enhanced Mode worked!
> It sees all the devices properly now.
>
> hdc: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15

If you want to get decent throughput from your DVD drive, you may also 
want my combined_mode= patch.  Boot with combined_mode=libata and 
libata.atapi=1 and I think you'll get good behavoir.  Last I checked 
the patch was sitting in one of Jeff's libata trees.

Jesse

Jesse
