Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278136AbRJWRtd>; Tue, 23 Oct 2001 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278142AbRJWRtX>; Tue, 23 Oct 2001 13:49:23 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:22029 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S278136AbRJWRtL>; Tue, 23 Oct 2001 13:49:11 -0400
Date: Tue, 23 Oct 2001 19:49:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shailabh Nagar <nagar@us.ibm.com>, Reto Baettig <baettig@scs.ch>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
Message-ID: <20011023194935.A12005@suse.de>
In-Reply-To: <20011023084238.C638@suse.de> <E15w4Kt-0006RM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15w4Kt-0006RM-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2001, Alan Cox wrote:
> > request the lower level driver can handle. This is typically 127kB, for
> > SCSI it can be as much as 512kB currently and depending on the SCSI
> 
> We really btw should make scsi default to 128K - otherwise all the raid
> stuff tends to go 127K, 1K, 127K, 1K and have to handle partial stripe
> read/writes

Fine with me, the major reason for doing 255 sectors and not 256 was IDE
of course... So feel free to change the default host max_sectors to 256.

-- 
Jens Axboe

