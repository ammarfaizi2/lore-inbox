Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUDTXzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUDTXzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUDTXzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:55:47 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:5648 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S263860AbUDTXy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:54:56 -0400
Message-ID: <DDF9139AA996D511BBDE00508BB927450A208C82@nbhexch1.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [linux-usb-devel] USB mass storage device has SCSI i/o errors
	, kernel > 2.6.3
Date: Wed, 21 Apr 2004 11:54:19 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

>> I have noticed an issue with writing to a USB mass storage device, 
>> which is a flash-rom-based mp3 player.
>> [...]
>> I have verified that this issue still occurs with 2.6.6-rc1-bk4, as 
>> requested by Andrew Morton.  This error was never noticed in any 
>> kernel v2.6.3 or less; including v2.4.x kernels; both stock 
>> and with -wolk and -mm patchsets.
> 
> It's possible that this is caused by a recently-introduced 
> bug in the UHCI driver.  A patch was posted yesterday:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108238832020
> 721&q=raw

I've applied this patch to my 2.6.6-rc1-bk4 kernel, and have not noticed a
reoccurance of the error since then.  I had a mini "test-suite" (basically
copied 48Mb of files to the device, "sync"ed, then deleted the files and
then "sync"ed again), which I've run 6 times without a flaw - previously the
error messages were happening on a frequent basis.

Therefore, I'm fairly confident that the patch has solved my issue.

Thanks,

James Roberts-Thomson
Senior Systems Engineer	DDI +64 4 494 4436
Infrastructure Projects	Tel +64 4 494 4000
The National Bank of New Zealand Limited	Fax +64 4 802 8509
----------
Another megabytes the dust.


This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
