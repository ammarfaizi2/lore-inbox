Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932816AbWKSSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWKSSou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWKSSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:44:50 -0500
Received: from 1wt.eu ([62.212.114.60]:20741 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932816AbWKSSou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:44:50 -0500
Date: Sun, 19 Nov 2006 19:44:36 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christian Schmidt <lkml@digadd.de>, linux-kernel@vger.kernel.org
Subject: Re: How to format a disk in an USB-Floppy-drive
Message-ID: <20061119184436.GC577@1wt.eu>
References: <456081CE.9090205@digadd.de> <Pine.LNX.4.61.0611191925220.24349@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611191925220.24349@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 07:25:34PM +0100, Jan Engelhardt wrote:
> 
> > How do I actually low-level format a floppy disk in an USB-Floppy-Disk-Drive?
> >
> > I tried as with usual drives, using fdformat:
> >
> > [~]>fdformat /dev/sdd
> > Could not determine current format type: Invalid argument
> >
> > But setting the format failed as well:
> > [~]>setfdprm -p /dev/sdd 1440/1440
> > ioctl: Invalid argument
> >
> > Next up scsifmt:
> >
> > [~]>./scsifmt /dev/sdd fmt
> > scsifmt: non-sense ioctl error
> >
> > Didn't work too well, too. Any ideas?
> 
> 
> Does not mkfs suffice?

No, he's talking about low-level format. This is necessary before writing
anything on a floppy for the first time or after defects have been detected
(remember these old ages ?).

Cheers,
Willy

