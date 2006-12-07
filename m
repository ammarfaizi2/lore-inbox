Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163135AbWLGSIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163135AbWLGSIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163139AbWLGSIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:08:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46103 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1163135AbWLGSIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:08:48 -0500
Date: Thu, 7 Dec 2006 13:08:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Matthias Schniedermeyer <ms@citd.de>
cc: linux-kernel@vger.kernel.org, <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [usb-storage]  single bit errors on files stored on USB-HDDs
 via USB2/usb_storage
In-Reply-To: <45773DD2.10201@citd.de>
Message-ID: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Matthias Schniedermeyer wrote:

> Hi
> 
> 
> I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
> (currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)
> 
> After i realised about a year(!) ago that the files copied to the HDDs
> sometimes aren't identical to the "original"-files i changed my
> procedured so that each file is MD5 before and after and deleted/copied
> again if an error is detected.
> 
> My averate file size is about 1GB with files from about 400MB to 5000MB
> I estimate the average error-rate at about one damaged file in about
> 10GB of data.
> 
> I'm not sure and haven't checked if the files are wrongly written or
> "only" wrongly read back as i delete the defective files and copy them
> again.
> 
> Today i copied a few files back and checked them against the stored MD5
> sums and 5 files of 86 (each about 700 MB) had errors. So i copied the 5
> files again. 4 of the files were OK after that and coping the last file
> the third time also resulted in the correct MD5.
> 
> This time i kept the defective files and used "vbindiff" to show me the
> difference. Strangly in EVERY case the difference is a single bit in a
> sequence of "0xff"-Bytes inside a block of varing bit-values that
> changed a "0xff" into a "0xf7".
> Also interesting is that each error is at a 0xXXXXXXX5-Position
> 
> Attached is a file with 5 of the 6 differences named 1-5. Of each of the
> 5 2x3 lines-blocks the first 3 lines are the original the following 3
> lines contain the error in the middle row 6th value.
> 
> NEVER did i see any messages in syslog regarding erros or an aborting
> program due to errors passed down from the kernel or something like that.

This was almost certainly caused by hardware flaws in the USB interface 
chips of the enclosures.  There's nothing the kernel can do about it 
because the errors aren't reported; all that happens is that incorrect 
data is sent to or from the drive.

Alan Stern

