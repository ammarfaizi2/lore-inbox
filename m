Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUB2IHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUB2IHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:07:06 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262014AbUB2IHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:07:04 -0500
Date: Sun, 29 Feb 2004 08:07:26 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402290807.i1T87QMn000287@81-2-122-30.bradfords.org.uk>
To: Stephen Satchell <list@satchell.net>, Michael Joy <mdj00b@acu.edu>
Cc: "'Nathan Scott'" <nathans@sgi.com>,
       "'Nico Schottelius'" <nico-kernel@schottelius.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1078004585.3347.14.camel@ssatchell1.pyramid.net>
References: <20040225231045.LJJM25915.lakemtao08.cox.net@nagasaki>
 <1078004585.3347.14.camel@ssatchell1.pyramid.net>
Subject: RE: another hard disk broken or xfs problems?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Stephen Satchell <list@satchell.net>:
>   /bin/nice -n 15 /bin/dd if=/dev/hda of=/dev/null bs=128k
>   /bin/nice -n 15 /bin/dd if=/dev/hdc of=/dev/null bs=128k
>   /bin/nice -n 15 /bin/dd if=/dev/sda of=/dev/null bs=128k
> 
> This ensures that all sectors are readable, regardless of file system
> state, and relocates and reassigns those sectors that can be read in any
> way.

The majority of drives do not re-allocate on read, only on write.
Therefore, the above cron jobs will simply find them each time they
run, unless something writes to the defective block inbetween runs.

John.
