Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbUAGAST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUAGAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:18:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:43202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266108AbUAGASS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:18:18 -0500
Date: Tue, 6 Jan 2004 16:11:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 2.6.0 - SCSI (driver aha152x) related
Message-Id: <20040106161148.2a3ea6bc.rddunlap@osdl.org>
In-Reply-To: <200401070008.36922.kiza@gmx.net>
References: <200401070008.36922.kiza@gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004 00:08:36 +0100 Oliver Feiler <kiza@gmx.net> wrote:

| Hi,
| 
| I have the following reproducable oops happening with 2.6.0, see attached file 
| oops-2.6.0-scsi. It was captured and processed on -test11, but also happens 
| on 2.6.0. I've also attached dmesg, .config and output from ver_linux from 
| the system.
| 
| It's a 486 ISA only system with an Adaptec AVA-1520 (aha152x) SCSI card. A 
| Panasonic DVD-RAM LF-D101 drive is the only device attached to the bus. The 
| oops only seems to happen after I exchanged the disc in the drive at least 
| once since reboot. If I boot with a disc in the drive I can mount it a dozen 
| of times and it works just fine. If I eject the disc and insert it again, the 
| oops occurs as soon as I mount it. The system hangs then, I cannot switch 
| consoles or type anything. Rebooting with ctrl+alt+del however works until 
| "unmount: / device is busy".
| 
| An IDE CD-ROM works fine so it should be related to the SCSI driver.
| 
| I know this stuff is very ancient now, but if someone is interested in working 
| on the problem I'd be quite happy. Let me know if there is any more info you 
| need.
| 
| Bye,
| Oliver

Yes, this has been reported several times.
Ah, patch that should fix it was merged on Dec. 20.  See
http://marc.theaimsgroup.com/?l=bk-commits-head&m=107283358922205&w=2
or
http://linus.bkbits.net:8080/linux-2.5/cset@1.1474.36.5?nav=index.html|ChangeSet@-3w

so it should be fixed in 2.6.1-rc1.

--
~Randy
