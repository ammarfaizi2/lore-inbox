Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVCWEIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVCWEIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVCWEIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:08:00 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:5351 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262760AbVCWEHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:07:52 -0500
Subject: RE: [PATCH] - Fusion-MPT much faster as module
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
In-Reply-To: <91888D455306F94EBD4D168954A9457C01AEB1F7@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C01AEB1F7@nacos172.co.lsil.com>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 22:07:43 -0600
Message-Id: <1111550863.5520.92.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 13:35 -0700, Moore, Eric Dean wrote:
> I still wonder if the SPI transport layer will work for RAID volumes.  
> Do you know if the spi transport layer supports dv on hidden devices in a
> raid volume? 
> Meaning these hidden physical disks will not been seen by the block layer,
> however 
> spi transport layer would be aware so dv can be performed those hidden disk?

I recall this being discussed, and the conclusion being that we could
allow a flag to bar attachment of the ULD.  So the underlying discs
would have a scsi_device but no sd device.  Then the spi_transport class
will work fine on them but the user wouldn't be able to open them or
mount anything.

James


