Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSHGIKc>; Wed, 7 Aug 2002 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSHGIKc>; Wed, 7 Aug 2002 04:10:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:29451 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316662AbSHGIKb>; Wed, 7 Aug 2002 04:10:31 -0400
Message-ID: <3D50D6E5.5A81710F@aitel.hist.no>
Date: Wed, 07 Aug 2002 10:14:29 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Disk (block) write strangeness
References: <20020805184921.GC2671@unthought.net> <1028578632.18156.71.camel@irongate.swansea.linux.org.uk> <20020805190706.GD2671@unthought.net> <3D4FE0B9.751A3E92@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:

> I think it should be possible for the firmware on a good disk to
> prevent such artifacts. But I think you can find disks that just
> keeps trying to write even while power is failing.
> 
That could might give you some (sub)blocks out of order, if the disk
firmware falsely believes that it is free to reorder anything
that reach its internal cache.   Writing to the bitter end
will turn at least one block to garbage as write current fail
in the middle.

Alan Cox wrote:
> *) or the disk internal logic bears no resemblance to the antiquated API
> it fakes for the convenience of interface hardware and software

One may then wonder if journalling is a safe thing to do,
with out-of-order writes exposed by a power failure...

Helge Hafting
