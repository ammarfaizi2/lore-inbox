Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSIJSlH>; Tue, 10 Sep 2002 14:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSIJSlG>; Tue, 10 Sep 2002 14:41:06 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17395
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317980AbSIJSkb>; Tue, 10 Sep 2002 14:40:31 -0400
Subject: RE: [RFC] Multi-path IO in 2.5/2.6 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167D03E@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E10640167D03E@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 19:48:26 +0100
Message-Id: <1031683706.1537.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 17:34, Cameron, Steve wrote:
> 1. Install normally to disk-A, remove disk-A from the system.
> 2. Install normally to disk-B.  Install disk-A into the system.
>    and boot from disk-B.  (now I can safely copy from disk-A, which has
>    no actively mounted partitions.)
> 3.  Create multipath devices on disk-C, one for each partition.
>    The partitions are bigger than those on disk-A, to allow for md to
> 	put its data at the end.
> 4.  Copy, (using dd) the partitions from disk-A to the md devices.
> 
> 5.  mount the md devices, and chroot to the md-root device.
>     Try to figure out how to run lilo to make booting from disk-C possible
>     also, initrd modifications to insmod multipath.o, mount the md devices,
>     etc.  This part, (making lilo work) I never was able to figure out.
> 
>   Would boot up and say "LI" then stop... or various other problems
>   that I can't quite recall now.  (this was a couple weeks ago)

Sounds like geometry mismatches. You need to be sure that the BIOS disk
mappings are constant and that the geometries match. The former can be a
big problem. If your failed drive falls off the scsi bus scan then your
BIOS disk 0x80 becomes the second disk not the first and life starts to
go down hill from that moment.


