Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVIHTAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVIHTAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVIHTAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:00:49 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48532 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964940AbVIHTAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:00:49 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662B1F@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: Jack Byer <ojbyer@usa.net>, linux-kernel@vger.kernel.org
Subject: RE: legacy megaraid driver bug in mm-series
Date: Thu, 8 Sep 2005 15:00:34 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, September 05, 2005 9:06 PM, Jack Byer wrote:
> 2.6.12-mm1:	will not compile megaraid driver
I've tried and it works fine.
I'm not sure where the problem is related to compilation.
Please provide more details.

Thank you,

Seokmann

> -----Original Message-----
> From: Jack Byer [mailto:ojbyer@usa.net] 
> Sent: Monday, September 05, 2005 9:06 PM
> To: linux-kernel@vger.kernel.org
> Subject: legacy megaraid driver bug in mm-series
> 
> My AMI megaraid card no longer works with recent mm-series 
> kernels. The
> bug appears on mm- kernels newer than 2.6.12-rc6-mm1; mainline kernels
> are not affected.
> 
> The driver will load and detect both devices on the card (sda 
> and sdb).
> It will scan each device and read the partition table successfully,
> however the megaraid driver message will include the following errors:
> 
> sda: sector size 0 reported, assuming 512.
> sda: asking for cache data failed.
> sda: assuming drive cache: write through
> 
> When the kernel tries to mount the root file system, I get 
> the following
> error:
> 
> ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev
> sda3, block 2, size 4096)
> ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev
> sda3, block 16, size 4096)
> VFS: Cannot open root device "sda3" or unknown-block(0,3)
> 
> Here is a summary of the kernels I have tested for this bug:
> 
> 2.6.11-mm1:	works
> 2.6.11-mm4:	works
> 2.6.12-rc5-mm1:	will not compile
> 2.6.12-rc6-mm1:	works
> 2.6.12-mm1:	will not compile megaraid driver
> 2.6.12-mm2:	broken
> 2.6.13-mm1:	broken
> 
> 2.6.12:		works
> 2.6.13:		works
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
