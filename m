Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUHaIyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUHaIyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHaIxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:53:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267526AbUHaIxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:53:11 -0400
Message-ID: <41343C66.3080804@pobox.com>
Date: Tue, 31 Aug 2004 04:52:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [patch] libata: add ioctls to support SMART
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de> <41343B2A.80909@gmx.de>
In-Reply-To: <41343B2A.80909@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Prakash K. Cheemplavam wrote:
> | John W. Linville wrote:
> | | Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
> | | supporting SMART w/ unmodified smartctl and smartd userland binaries.
> ~ > I just tried to give it a go with libata from 2.6.9-rc1. I had to fix
> | one rejects but the patching seemed to go fine beside that. Nevertheless
> | after a boot with patched libata I get:
> |
> | smartctl -a /dev/sda
> [snip]
> 
> | Device does not support SMART
> 
> Just wanted
> 
> Just wanted to say that smartctl -a -d ata /dev/sda works, as John
> Linville and now Bruce aLlen suggested to try.


As I noted in another email, be careful...  that patch bypasses the SCSI 
command synchronization, so you could potentially send a SMART command 
to the hardware while another command is still in progress.

	Jeff


