Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWJPK2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWJPK2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWJPK2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:28:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23948 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161256AbWJPK2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:28:24 -0400
Subject: Re: Why aren't partitions limited to fit within the device?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <1160983735.32674.4.camel@frg-rhel40-em64t-03>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	 <1160752047.25218.50.camel@localhost.localdomain>
	 <17714.52626.667835.228747@cse.unsw.edu.au>
	 <1160983735.32674.4.camel@frg-rhel40-em64t-03>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 11:54:32 +0100
Message-Id: <1160996072.24237.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 09:28 +0200, ysgrifennodd Xavier Bestel:
> > Hmmm.. So Alan things a partially-outside-this-disk partition
> > shouldn't show up at all, and Andries thinks it should.
> > And both give reasonably believable justifications.
> 
> Maybe the whole part table should be marked as "weird" to let userspace
> run a diagnostics/repair tool on the disk.

I actually like the "read only" suggestion that was made. Allow data
access but protect from damage.

Both options will allow 'repair' of a broken partition table as the
partition will show up in fdisk which accesses stuff directly, and when
that causes a revalidate it will re-appear to the kernel.

Incidentally the question of exactly what libata should do about HPA
handling also needs sorting out.

Alan

