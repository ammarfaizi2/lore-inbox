Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSBLIV7>; Tue, 12 Feb 2002 03:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290829AbSBLIVs>; Tue, 12 Feb 2002 03:21:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34315 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285352AbSBLIVh>;
	Tue, 12 Feb 2002 03:21:37 -0500
Date: Tue, 12 Feb 2002 09:21:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
Message-ID: <20020212092109.Y729@suse.de>
In-Reply-To: <20020212001547.GA22586@codepoet.org> <E16aQu1-00008C-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16aQu1-00008C-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Alan Cox wrote:
> > I notice that in linux/drivers/scsi/scsi_merge.c you seem to
> > be reverting the MO drive clustering fix from Jens:
> >     http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.0/1321.html
> > 
> > Was this intentional?  If so, why?
> 
> I want to find out why it was done first and then test it. Leaving it out
> will ensure it bugs me until I test it

If you leave it out, you surely want to make sure that the other request
init and re-init paths agree on the clustering for MO devices. Because
they don't.

As far as I'm concerned, removing the MO conditional wrt clustering is
the right fix.

-- 
Jens Axboe

