Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310398AbSCLE1P>; Mon, 11 Mar 2002 23:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310393AbSCLE1D>; Mon, 11 Mar 2002 23:27:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310394AbSCLE0t>;
	Mon, 11 Mar 2002 23:26:49 -0500
Message-ID: <3C8D8376.8010907@mandrakesoft.com>
Date: Mon, 11 Mar 2002 23:26:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your proposal sounds 100% ok to me...

For the details of the userspace interface (for both ATA and SCSI), my 
idea was to use standard read(2) and write(2).

Any number of programs can open /dev/ata/hda/control or 
/dev/scsi/sdc/control.  write(2) submits requests, read(2) consumes 
command responses, perhaps buffering a bit so that multiple responses 
are not lost if userspace is slow.

Maybe it's a cheesy way to avoid ioctl(2), maybe not...

    Jeff




