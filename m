Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUCOFyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUCOFyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:54:23 -0500
Received: from fmr03.intel.com ([143.183.121.5]:18602 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262279AbUCOFyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:54:21 -0500
Message-Id: <200403150553.i2F5rum14058@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <thornber@redhat.com>
Subject: RE: [PATCH] backing dev unplugging
Date: Sun, 14 Mar 2004 21:53:58 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQG2W8rodshR8XpS2iBDfBt64JimwDdbiDQ
In-Reply-To: <20040310115545.16cb387f.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> Andrew Morton on Wed March 10, 2004 11:56 AM
>Jens Axboe <axboe@suse.de> wrote:
>> Here's a first cut at killing global plugging of block devices to reduce
>> the nasty contention blk_plug_lock caused. This introduceds per-queue
>> plugging, controlled by the backing_dev_info.
>
>This is such an improvement over what we have now it isn't funny.
>
>Ken, the next -mm is starting to look like linux-3.1.0 so I think it
>would be best if you could benchmark Jens's patch against 2.6.4-rc2-mm1.


Our latest measurement on the 32P, 1000 disks setup indicates this patch
is working as expected performance wise.  We saw 200% improvement on the
throughput compare to global blk_plug_list.  (compare to the per-cpu
blk_plug_list, performance is the same).

- Ken


