Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUCNE16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbUCNE16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:27:58 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:52959 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263273AbUCNE14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:27:56 -0500
Subject: Re: 2.6.3-mm4 scsi_delete_timer() oops
From: James Bottomley <James.Bottomley@steeleye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040314041047.GK655@holomorphy.com>
References: <20040314041047.GK655@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 23:27:50 -0500
Message-Id: <1079238471.1759.74.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 23:10, William Lee Irwin III wrote:
> Mar 13 19:41:59 holomorphy kernel: EIP:    0060:[<00000000>]    Not tainted VLI
[...]
> Mar 13 19:41:59 holomorphy kernel:  [<c0358076>] scsi_delete_timer+0x16/0x30
> Mar 13 19:41:59 holomorphy kernel:  [<c0373de9>] ahc_linux_run_complete_queue+0x69/0xd0

This trace doesn't make sense to me.  A null EIP usually indicates
jumping through a NULL function pointer.  There are no fptr derefs in
scsi_delete_timer.  Also ahc_linux_run_complete_queue doesn't call
scsi_delete_timer.

Could you try to reproduce and get a more meaningful backtrace?

Thanks,

James


