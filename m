Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWFPJVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWFPJVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFPJVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:21:15 -0400
Received: from mail-gw3.adaptec.com ([216.52.22.36]:1744 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751021AbWFPJVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:21:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HEADS UP for gdth driver users
Date: Fri, 16 Jun 2006 11:21:11 +0200
Message-ID: <EF6AF37986D67948AD48624A3E5D93AFAA930A@mtce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HEADS UP for gdth driver users
Thread-Index: AcaL80Ns+DR3EwZWTPqzo8NvQ+HBggFL5BrA
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <hch@lst.de>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the changelog and signed-off-by for this patch. Of course I will
follow the SubmittingPatches guideline for future patches, sorry for not
doing it for that patch. 
I don't send this mail in the recommended form because the patch is
already added to the mm tree and I want to avoid a duplicate (or does it
not happen?).

-----------------------------------------------------------------------
[PATCH] gdth: remove the scsi_request interface from the gdth driver

From: Achim Leubner <Achim_Leubner@adaptec.com>

I removed all scsi_allocate_request()/scsi_release_request() calls and
all scsi_request structures from the driver and I replaced scsi_do_req()
call with a direct call to gdth_queuecommand() to send the request.
Furthermore I made some changes to preserve compatibility to the 2.4.x
kernels.

Signed-off-by: Achim Leubner <Achim_Leubner@adaptec.com>

-----------------------------------------------------------------------

Thanks,
Achim

=======================
Achim Leubner
Software Engineer / RAID drivers
ICP vortex GmbH / Adaptec Inc.
Phone: +49-351-8718291
 


-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Freitag, 9. Juni 2006 20:34
To: Leubner, Achim
Cc: hch@lst.de; linux-kernel@vger.kernel.org
Subject: Re: HEADS UP for gdth driver users

On Fri, 9 Jun 2006 13:03:08 +0200
"Leubner, Achim" <Achim_Leubner@adaptec.com> wrote:

> Attached you find a patch to remove the scsi_request interface from
the
> gdth driver.

Please send a changelog and a Signed-off-by: for this patch, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
Documentation/SubmittingPatches.

Please ensure that future patches are prepared in `patch -p1' form, as
per
the same documents, thanks.


