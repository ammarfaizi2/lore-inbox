Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRAXU1o>; Wed, 24 Jan 2001 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAXU1e>; Wed, 24 Jan 2001 15:27:34 -0500
Received: from ns2.us.dell.com ([143.166.82.252]:12815 "EHLO ns2.us.dell.com")
	by vger.kernel.org with ESMTP id <S129632AbRAXU1T>;
	Wed, 24 Jan 2001 15:27:19 -0500
Date: Wed, 24 Jan 2001 14:27:08 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <mjacob@feral.com>, <linux-kernel@vger.kernel.org>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <004901c08641$54d86d40$1a040a0a@zeusinc.com>
Message-ID: <Pine.LNX.4.30.0101241423101.16045-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Tom Sightler wrote:

> I temporarily disabled that code and the
> increase in IO's per second is measurable, though not earth shattering, but
> I was afraid to leave it that way because fast corrupted data is worth much
> less that only slightly slower good data.

I don't believe the problem is data corruption, but that there could be
some CRC data residual from an I/O which causes the driver to issue a
SCSI bus reset.  As bus resets really kill performance, Doug thought it
better to slow the drive to 80 rather than run at 160 and have occasional
bus resets.

-- 
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
