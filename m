Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUHAQpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUHAQpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 12:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUHAQpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 12:45:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:63900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266005AbUHAQpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:45:08 -0400
Date: Sun, 1 Aug 2004 09:24:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI removable devices problem
Message-Id: <20040801092421.3f138fac.rddunlap@osdl.org>
In-Reply-To: <20040801141931.6e026422.pochini@shiny.it>
References: <20040801141931.6e026422.pochini@shiny.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004 14:19:31 +0200 Giuliano Pochini wrote:

| 
| 
| It seems that 2.6.7 reads the partition table only once: when the scsi unit
| is added to the list during boot or when I send the "add-single-device"
| command. This is a problem with removable devices because if the drive
| hasn't a disk inserted at boot time, attempting to mount a partitioned disk
| always results in:
| 
| mount: /dev/sdb1 is not a valid block device
| 
| Also, bad things may happen (not tested) if a disk was in during boot and I
| replace it with another one with a different partitioning.
| 
| As a workaround I have to send the "remove-single-device" command after
| having unmounted a volume and "add-single-device" after I have inserted a
| new one. I don't know when this problem was introduced, sorry.

I think that it's been this way for some time now...

Does using
	blockdev --rereadpt /dev/sdb1
help?

--
~Randy
