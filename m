Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbRGNUI4>; Sat, 14 Jul 2001 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbRGNUIq>; Sat, 14 Jul 2001 16:08:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:64262 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264869AbRGNUIb>; Sat, 14 Jul 2001 16:08:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Sat, 14 Jul 2001 22:11:30 +0200
X-Mailer: KMail [version 1.2]
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <20010715025001.B6722@weta.f00f.org>
In-Reply-To: <20010715025001.B6722@weta.f00f.org>
MIME-Version: 1.0
Message-Id: <0107142211300W.00409@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 July 2001 16:50, Chris Wedgwood wrote:
> On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:
>
>     As far as I can tell none of them at least in the IDE world
>
> SCSI disk must, or at least some... if not, how to peopel like NetApp
> get these cool HA certifications?

Atomic commit.  The superblock, which references the updated version 
of the filesystem, carries a sequence number and a checksum.  It is 
written to one of two alternating locations.  On restart, both
locations are read and the highest numbered superblock with a correct
checksum is chosen as the new filesystem root.

--
Daniel
