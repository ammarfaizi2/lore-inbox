Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTKNUXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKNUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:23:50 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:63748 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264288AbTKNUXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:23:47 -0500
Date: Fri, 14 Nov 2003 21:23:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Message-ID: <20031114202339.GB18107@win.tue.nl>
References: <20031114113224.GR21265@home.bofhlet.net> <bp2mab$sts$1@sea.gmane.org> <200311140945.36537.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311140945.36537.gene.heskett@verizon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:45:36AM -0500, Gene Heskett wrote:

> Nov 14 09:19:51 coyote kernel: hub 3-2:1.0: new USB device on port 3, assigned address 9
> Nov 14 09:19:51 coyote kernel: scsi4 : SCSI emulation for USB Mass Storage devices
> Nov 14 09:19:52 coyote kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
> Nov 14 09:19:52 coyote kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
> Nov 14 09:19:52 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
> Nov 14 09:19:52 coyote kernel: sda: assuming drive cache: write through
> Nov 14 09:19:52 coyote kernel:  sda: sda1
> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF (i_pos 0)
> Nov 14 09:20:34 coyote kernel:     File system has been set read-only
> 
> Comments?  Screwed up kernel .config? Is mount "-t vfat" the 
> correct filesystem?

It would have been interesting to see the filesystem after this error message.
Can you reproduce the error?

(vfat? I don't know - most cameras just use msdos, but vfat doesnt harm,
I suppose)

The error message means that the fatfs followed a chain of clusters in order
to delete them all and found a free cluster before finding an end-of-file mark.

