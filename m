Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVDZIOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVDZIOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVDZIOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:14:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31926 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261385AbVDZIOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:14:30 -0400
Date: Tue, 26 Apr 2005 10:14:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Randy Gardner <lkml@bushytails.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
Message-ID: <20050426081419.GA1851@suse.de>
References: <426972E5.4000408@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426972E5.4000408@bushytails.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22 2005, Randy Gardner wrote:
> Apr 21 19:18:57 localhost kernel: ISO 9660 Extensions: Microsoft Joliet 
> Level 3
> Apr 21 19:18:57 localhost kernel: ISO 9660 Extensions: RRIP_1991A
> Apr 21 19:19:27 localhost kernel: hdf: command error: status=0x51 { 
> DriveReady SeekComplete Error }
> Apr 21 19:19:27 localhost kernel: hdf: command error: error=0x54 { 
> AbortedCommand LastFailedSense=0x05 }

Can you read the disc with dd safely? Eg dd if=/dev/hdf of=/dev/null
bs=2k

The multimode suggestion will not make any difference, atapi drives
don't do multimode at all anyways. It's an ata pio addition.

Try disabling dma on the drive as well.


-- 
Jens Axboe

