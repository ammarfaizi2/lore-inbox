Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTE2XOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTE2XOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:14:08 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:31696 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263152AbTE2XOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:14:07 -0400
Date: Fri, 30 May 2003 00:27:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: IRQ_NONE definition in NCR5380 driver...
Message-ID: <Pine.LNX.4.53.0305300024550.14345@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently the NCR5380.h defines IRQ_NONE to be 255, is there any special
reason for this? why not use UINT32_MAX-1?..

The VAX actually has got more than 255 interrupt handlers which we've
mapped to IRQs, and it happens the external SCSI interface is at 255, so
this makes it a bit sick...

I've redefined it in our tree to 65535 but I see no reason not to go to
the above... any objections?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

