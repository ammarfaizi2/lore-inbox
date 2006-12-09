Return-Path: <linux-kernel-owner+w=401wt.eu-S1760780AbWLINON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760780AbWLINON (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760831AbWLINON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:14:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56025 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760780AbWLINOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:14:12 -0500
Date: Sat, 9 Dec 2006 13:21:20 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: rakheshster@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: VCD not readable under 2.6.18
Message-ID: <20061209132120.7af3ce66@localhost.localdomain>
In-Reply-To: <20061209060602.98025.qmail@web57812.mail.re3.yahoo.com>
References: <20061209060602.98025.qmail@web57812.mail.re3.yahoo.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't see any responses after the post linked to above, so I'd like to add that I too get this problem and that I've tried with various VCDs and players. In previous versions of these distros I could just mount the VCD and copy the *.DAT files across; but in the current versions I can't even mount! dmesg gets flooded with errors such as the below: 


> 
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> ide: failed opcode was: unknown
> ATAPI device hdc:
>   Error: Illegal request -- (Sense key=0x05)
>   Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
>   The failed "Read 10" packet command was: 
>   "28 00 00 00 73 f2 00 00 01 00 00 00 00 00 00 00 "

Your system tried to read a Video data block. The usual cure for this
problem is to remove Gnome, or at least kill all the Gnome stuff and flip
to init level 3 then mount the cd from the command line. 

The kernel is correctly reporting it was asked to do something stupid.
Older kernels would fail to report many of these errors due to a bug in
the ide-cd reporting logic.

