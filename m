Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKRJHT>; Mon, 18 Nov 2002 04:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSKRJHT>; Mon, 18 Nov 2002 04:07:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:43194 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261689AbSKRJHS>;
	Mon, 18 Nov 2002 04:07:18 -0500
Message-ID: <3DD8AF65.BF2EF851@digeo.com>
Date: Mon, 18 Nov 2002 01:14:13 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: scsi in 2.5.48
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 09:14:13.0712 (UTC) FILETIME=[DCC00500:01C28EE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().
Running an `ls -lR' against an IDE disk gets it going again.  Seems
that the driver is failing to call into the elevator to fetch more
requests.  The unplug activity from the IDE reads is sufficient to
keep the SCSI driver limping along.

The driver is aic7xxx.
