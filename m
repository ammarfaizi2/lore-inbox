Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933055AbWKSTZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055AbWKSTZK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbWKSTZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:25:10 -0500
Received: from 1wt.eu ([62.212.114.60]:21509 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S933055AbWKSTZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:25:08 -0500
Date: Sun, 19 Nov 2006 20:25:02 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christian Schmidt <lkml@digadd.de>, linux-kernel@vger.kernel.org
Subject: Re: How to format a disk in an USB-Floppy-drive
Message-ID: <20061119192502.GA23136@1wt.eu>
References: <456081CE.9090205@digadd.de> <Pine.LNX.4.61.0611191925220.24349@yvahk01.tjqt.qr> <20061119184436.GC577@1wt.eu> <Pine.LNX.4.61.0611192015050.6208@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611192015050.6208@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 08:15:31PM +0100, Jan Engelhardt wrote:
> 
> On Nov 19 2006 19:44, Willy Tarreau wrote:
> >On Sun, Nov 19, 2006 at 07:25:34PM +0100, Jan Engelhardt wrote:
> >> > [~]>./scsifmt /dev/sdd fmt
> >> > scsifmt: non-sense ioctl error
> >> >
> >> > Didn't work too well, too. Any ideas?
> >> 
> >> 
> >> Does not mkfs suffice?
> >
> >No, he's talking about low-level format. This is necessary before writing
> >anything on a floppy for the first time or after defects have been detected
> >(remember these old ages ?).
> 
> Yeah but the scsi *disk* driver does not seem to handle *floppy* 
> requests (just as it does not handle *cdrom* ioctls). I sense a Missing 
> Feature here.

I'm just wondering whether an SCSI floppy drive should support the hard
disk command set (including low-level fmt). I'm not even sure that our
sd driver supports those commands itself ! Clearly smelling -ENOFEATURE...

Regards,
Willy

