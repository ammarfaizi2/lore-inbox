Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSKRJig>; Mon, 18 Nov 2002 04:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSKRJig>; Mon, 18 Nov 2002 04:38:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:7099 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261836AbSKRJie>;
	Mon, 18 Nov 2002 04:38:34 -0500
Message-ID: <3DD8B6B9.E9EAD230@digeo.com>
Date: Mon, 18 Nov 2002 01:45:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: scsi in 2.5.48
References: <3DD8AF65.BF2EF851@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 09:45:29.0547 (UTC) FILETIME=[3AD5B9B0:01C28EE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().

This makes it work again.


--- 25/drivers/scsi/scsi_lib.c~scsi-plug	Mon Nov 18 01:42:40 2002
+++ 25-akpm/drivers/scsi/scsi_lib.c	Mon Nov 18 01:42:44 2002
@@ -1024,7 +1024,6 @@ void scsi_request_fn(request_queue_t * q
 			/* can happen if the prep fails 
 			 * FIXME: elv_next_request() should be plugging the
 			 * queue */
-			blk_plug_device(q);
 			break;
 		}
 

_
