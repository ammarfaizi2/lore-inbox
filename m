Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTCEFsA>; Wed, 5 Mar 2003 00:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTCEFsA>; Wed, 5 Mar 2003 00:48:00 -0500
Received: from SPARCLINUX.MIT.EDU ([18.248.2.241]:57354 "EHLO
	sparclinux.mit.edu") by vger.kernel.org with ESMTP
	id <S262452AbTCEFr7>; Wed, 5 Mar 2003 00:47:59 -0500
Date: Wed, 5 Mar 2003 00:44:57 -0500
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI broken
Message-ID: <20030305054457.GA12564@osinvestor.com>
References: <3E658E51.4070505@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E658E51.4070505@cox.net>
User-Agent: Mutt/1.4i
From: rob@osinvestor.com (Rob Radez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 11:42:41PM -0600, David van Hoose wrote:
> Kernels 2.5.63 and 2.5.64 lock up when displaying the information for my 
> ZipDrive during SCSI probe. Attached is my .config for 2.5.64.

I suspect I'm seeing something similar.  On SPARC, I'm getting a hang
after displaying the information for my SCSI CD-ROM drive.

scsi0 : Sparc ESP100A-FAST
Vendor: SEAGATE   Model: ST31200W SUN1.05  Rev: 8724
Type:   Direct-Access                      ANSI SCSI revision: 02
Vendor: SEAGATE   Model: ST32155W SUN2.1G  Rev: 8456
Type:   Direct-Access                      ANSI SCSI revision: 02
Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 1755
Type:   CD-ROM                             ANSI SCSI revision: 02
<hang>

.config available on request.  Worked fine in 2.5.62, hangs in 2.5.63.
Reverting the scsi changes listed at
http://osinvestor.com/sparc/patch/2.5.63-revertscsi.diff allows 2.5.63
to boot.

Regards,
Rob Radez
