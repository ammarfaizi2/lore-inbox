Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWBMPAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWBMPAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWBMPAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:00:43 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:43528 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S1751771AbWBMPAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:00:42 -0500
Date: Mon, 13 Feb 2006 16:00:24 +0100
From: iSteve <isteve@rulez.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060213160024.5e01fa46@silver>
In-Reply-To: <43EFD42D.6040102@cfl.rr.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
	<20060211211440.3b9a4bf9@silver>
	<43EE8B20.7000602@cfl.rr.com>
	<2006021 <20060212114640.31765c3a@silver>
	<43EFD42D.6040102@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006 19:34:53 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:
> So you want to write data to the disc without using pktcdvd?  cdrwtool 
> -f allows you to write an image file to the disc, though I don't see why 
> you don't want to use pktcdvd.  If you want to be able to read/write the 
> disc on the fly, you must either use pktcdvd or format the disc in MRW 
> mode.
> 

I tried that. Mostly, writing failed. At cdrwtool's end, it looked like this:
using device /dev/cdrw
fixed packets
setting speed to 10
write file /root/udftest.img
4690KB internal buffer
setting write speed to 10x
writing at lba = 0, blocks = 32
wait_cmd: Input/output error
Command failed: 2a 00 00 00 00 00 00 00 20 00 00 00 - sense 05.24.00

At kernel's end:
cdrom: This disc doesn't have any tracks I recognize!

Once I, somehow, managed to write it. However, writing ISO9660 (yes, I know
that iso9660 doesn't support read/write; I use it for test though and I need
it working), attempt to read it returned this:

attempt to access beyond end of device
hdc: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
-- 
 -- iSteve
