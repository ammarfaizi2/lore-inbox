Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUCNEe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbUCNEe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:34:26 -0500
Received: from holomorphy.com ([207.189.100.168]:14604 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263100AbUCNEeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:34:24 -0500
Date: Sat, 13 Mar 2004 20:34:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm4 scsi_delete_timer() oops
Message-ID: <20040314043420.GL655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040314041047.GK655@holomorphy.com> <1079238471.1759.74.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079238471.1759.74.camel@mulgrave>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 23:10, William Lee Irwin III wrote:
>> Mar 13 19:41:59 holomorphy kernel: EIP:    0060:[<00000000>]    Not tainted VLI
> [...]
>> Mar 13 19:41:59 holomorphy kernel:  [<c0358076>] scsi_delete_timer+0x16/0x30
>> Mar 13 19:41:59 holomorphy kernel:  [<c0373de9>] ahc_linux_run_complete_queue+0x69/0xd0

On Sat, Mar 13, 2004 at 11:27:50PM -0500, James Bottomley wrote:
> This trace doesn't make sense to me.  A null EIP usually indicates
> jumping through a NULL function pointer.  There are no fptr derefs in
> scsi_delete_timer.  Also ahc_linux_run_complete_queue doesn't call
> scsi_delete_timer.
> Could you try to reproduce and get a more meaningful backtrace?

I'm pretty stumped as to what's going on with this. The stack is
moderately deep. It's also possible a fair fraction of the stuff is
garbage off the end of the stack and the real leaf routine is buried.


-- wli
