Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUHGW5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUHGW5B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUHGW5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:57:01 -0400
Received: from the-village.bc.nu ([81.2.110.252]:31428 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264531AbUHGW5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:57:00 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: dleonard@dleonard.net, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091887453.18408.46.camel@localhost.localdomain>
References: <20040806143258.GB23263@suse.de>
	 <Pine.LNX.4.44.0408061020220.8255-100000@pooka.dleonard.net>
	 <20040806224743.GA19131@suse.de>
	 <1091887453.18408.46.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091915668.19077.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 22:54:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually there is a seperate complication here for disks that probably
makes the problem a bit more complex for anything with partitions - that
is that SCSI commands are not per partition and I agree with you that we
don't want to get into filtering on that basis. Probably
that means CAP_SYS_RAWIO for anything not the true "whole device" node.

That leaves commands to one device that affect another "disk"  - eg a
firmware upgrade on a big storage array but those are RAWIO things
anyway

