Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUBUKoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 05:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUBUKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 05:44:36 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:25575 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261543AbUBUKof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 05:44:35 -0500
Subject: Re: [Patch 1/6] dm: endio method
From: Christophe Saout <christophe@saout.de>
To: Mike Christie <mikenc@us.ibm.com>
Cc: Joe Thornber <thornber@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40372BCE.7090708@us.ibm.com>
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti>
	 <40372BCE.7090708@us.ibm.com>
Content-Type: text/plain
Message-Id: <1077360278.6414.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:44:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 21.02.2004 schrieb Mike Christie um 10:58:

> This is DM's cloned bio. Is there a guarantee that this value should be 
> safe from lower level drivers overwriting it, or is it similar to b_rdev 
> for buffer_heads?

The block layer is allowed to remap the device. This is done for
partitions, e.g. hda5 -> hda + sector number change
(blk_partition_remap).


