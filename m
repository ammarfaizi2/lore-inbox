Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWJBRkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWJBRkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWJBRkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:40:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965164AbWJBRks (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:40:48 -0400
Date: Mon, 2 Oct 2006 13:40:39 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Tim Chen <tim.c.chen@intel.com>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Postal 56% waits for flock_lock_file_wait
Message-ID: <20061002174039.GA17764@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Tim Chen <tim.c.chen@intel.com>,
	"Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411> <1159723092.5645.14.camel@lade.trondhjem.org> <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com> <1159809081.5466.3.camel@lade.trondhjem.org> <1159811516.8907.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159811516.8907.38.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 06:51:56PM +0100, Alan Cox wrote:
 > Ar Llu, 2006-10-02 am 13:11 -0400, ysgrifennodd Trond Myklebust:
 > > Ext3 does not use flock() in order to lock its journal. The performance
 > > issues that he is seeing may well be due to the journalling, but that
 > > has nothing to do with flock_lock_file_wait.
 > 
 > The ext3 journal also generally speaking improves many-writer
 > performance as do the reservations so the claim seems odd on that basis
 > too. Rerun the test on a gigabyte iRam or similar and you'll see where
 > the non-media bottlenecks actually are

"or similar" maybe. The iRam is pretty much junk in my experience[*].
It rarely survives a mkfs, let alone sustained high throughput I/O.
(And yes, I did try multiple DIMMs, including ones which survive
 memtest86 just fine).

Another "Boots Windows, ship it" QA disaster afaics.

	Dave

[*] And from googling/talking with other owners, my experiences aren't unique.

-- 
http://www.codemonkey.org.uk
