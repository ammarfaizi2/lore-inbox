Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWGXX36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGXX36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWGXX36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:29:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16797 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932331AbWGXX35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:29:57 -0400
From: Neil Brown <neilb@suse.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Date: Tue, 25 Jul 2006 09:29:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17605.22477.933202.350306@cse.unsw.edu.au>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: loopback blockdevice driver partition support
In-Reply-To: message from Kasper Sandberg on Tuesday July 25
References: <1153783192.11477.7.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 25, lkml@metanurb.dk wrote:
> hello.. i was wondering if someone may have done some work to make the
> loopback driver support partitions..
> 
> i found that a guy had written a nice script that used sfdisk and
> dmsetup to use device mapper on a loopback image of an entire harddrive
> (using DOS partition table ofcourse) to create device mapper
> "partitions".
> 
> though this doesent quite meet my requirements, as i need to read an
> image of an amiga disk..
> 
> therefore it would seem like a good idea to make the loopback driver
> work with linux's partition table support, since it already supports
> this.
> 
> if anyone has done some work in this, please mail me, and possibly i can
> continue it if wanted. just want to know if anyone already has done
> something like it before i try at it myself..
> 

You could try wrapping an md/linear around it
 
mkdir -p /dev/md
mdadm -Bf -c4 -l linear -n1 -ap /dev/md/d0 /dev/loop0

then look at partitions in /dev/md/d0pN

NeilBrown

