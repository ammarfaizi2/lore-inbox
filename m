Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUCJUEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCJUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:04:21 -0500
Received: from fmr04.intel.com ([143.183.121.6]:29906 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262799AbUCJUER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:04:17 -0500
Message-Id: <200403102003.i2AK3qm16576@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <thornber@redhat.com>
Subject: RE: [PATCH] backing dev unplugging
Date: Wed, 10 Mar 2004 12:03:52 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQG2W8rodshR8XpS2iBDfBt64JimwAADDbg
In-Reply-To: <20040310115545.16cb387f.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, March 10, 2004 11:56 AM
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Here's a first cut at killing global plugging of block devices to reduce
> > the nasty contention blk_plug_lock caused. This introduceds per-queue
> > plugging, controlled by the backing_dev_info.
>
> This is such an improvement over what we have now it isn't funny.
>
> Ken, the next -mm is starting to look like linux-3.1.0 so I think it
> would be best if you could benchmark Jens's patch against 2.6.4-rc2-mm1.

I'm planning on couple experiments: one is just Jens's change on top of
what we have so we can validate the backing dev unplug. Then we will run
2.6.4-rc2-mm1 + Jens's patch.

- Ken


