Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUH0XRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUH0XRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUH0XRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:17:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:10730 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265196AbUH0XQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:16:55 -0400
Date: Fri, 27 Aug 2004 16:16:43 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <suparna@in.ibm.com>
cc: <linux-aio@kvack.org>, <mason@suse.com>, <linux-osdl@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: OSDL:  AIO-Stress summary for AIO patch set vs linux-2.6.8
Message-ID: <Pine.LNX.4.33.0408271452340.6008-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

I have done a summary of some aio-stress runs on our 1CPU and 2CPU hosts
to compare the performance of the latest version of Suparna's buffered AIO
patch set http://marc.theaimsgroup.com/?l=linux-aio&m=109285137710061&w=2
(less the aio-ra) to the linux-2.6.8 kernel.  I found up to a 442%
improvement and was wondering if anyone could explain it.

The buffered results on 1CPU/single disk/512M RAM/1 2G File showed:
     Sequential Reads:    -13.2%
     Random reads:        +32.7%


The buffered results on 2CPU/5 Disk striped Megaraid/1G RAM/1 4G File
showed:
    Sequential reads:      +2.1%
    Random Reads:         +442%


The improvement in buffered random reads from this patch set was +32% on
1CPU and +442% on 2CPU.  This was more than expected on the 2CPU host at
+442%.  It seems as though the 'buffered random reads' performance on the
unpatched linux-2.6.8 kernel is unexpectedly low at only 7.57MB/s on our
5 Disk striped Megaraid partition.

The buffered sequential reads on the 1CPU host were 13% slower, but they
did not change significantly on the 2CPU host.

There were no other serious regressions or changes within error.

The full summary is at:

http://developer.osdl.org/judith/aio/result_compare_2.6.8.html


Regards;

Judith Lebzelter
OSDL







