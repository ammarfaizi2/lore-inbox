Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284876AbRLEXzI>; Wed, 5 Dec 2001 18:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLEXzB>; Wed, 5 Dec 2001 18:55:01 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34316
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284856AbRLEXxG>; Wed, 5 Dec 2001 18:53:06 -0500
Date: Wed, 5 Dec 2001 15:48:26 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16BlnL-00080m-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10112051546300.9419-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Alan Cox wrote:

> > by the better generic block layer code.  I personally hope that a year
> > from now, if somebody wants to do a new SCSI driver, he won't even
> > _think_ about using the SCSI code, the driver will just take the
> > (generic SCSI) requests directly off the block queue. 
> 
> You still need the scsi code. There are a whole sequence of common, quite
> complex and generic functions that the scsi layer handles (in paticular
> error handling).
> 
> Turning it the right way I up definitely agree with. It should be the driver
> calling the scsi code to do bio->scsi request, and to do scsi error
> recovery, not vice versa.
> 
> There are also some tricky relationships
> 	queues are per logical unit number
> 	locking is mostly per controller
> 	resources are often per controller

Alan,

Nothing that can not be handled in the core-model described earlier;
however, I am positive that the suttle issues are more sticky than you are
revealing now.

Regards,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

