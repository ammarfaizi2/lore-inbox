Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276099AbRI1PC2>; Fri, 28 Sep 2001 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276104AbRI1PCS>; Fri, 28 Sep 2001 11:02:18 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:13714
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S276099AbRI1PCK>; Fri, 28 Sep 2001 11:02:10 -0400
Date: Fri, 28 Sep 2001 11:02:21 -0400
From: Chris Mason <mason@suse.com>
To: Matt Bernstein <matt@theBachChoir.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: weirdness in reiserfs
Message-ID: <643320000.1001689341@tiny>
In-Reply-To: <Pine.LNX.4.33.0109281509080.10065-100000@nick.dcs.qmul.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0109281509080.10065-100000@nick.dcs.qmul.ac.uk>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, September 28, 2001 03:44:19 PM +0100 Matt Bernstein
<matt@theBachChoir.org.uk> wrote:

> I have a 240GB reiserfs ataraid partition on one of my servers (2.4.9-ac10
> + ext3 0.9.9 + ext3 speedup + ext3 "experimental VM patch" + jfs 1.0.4),
> which I had populated with lots of little files, probably huge amounts of
> tail-packing going on.

[ slow deleting of 25GB, horrible latency ]

Hmmm, I'd be curious to see how 2.4.9-ac16 (or 2.4.10) performs there.  The
reiserfs delete code should be scheduling enough due to transaction
stop/starts that interactive performance isn't that bad.

You should be able to repeat your results by doing the same tests on sparse
files:

dd if=/dev/zero of=foo bs=1M count=1 seek=250000

-chris



