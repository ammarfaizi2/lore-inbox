Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUI1FcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUI1FcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 01:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUI1FcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 01:32:02 -0400
Received: from fmr12.intel.com ([134.134.136.15]:659 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267538AbUI1Fb7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 01:31:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 13:31:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD57A0@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSlF2gzCUz8dVg/RZOC3ST15GHeWAAApEnw
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>
X-OriginalArrivalTime: 28 Sep 2004 05:31:48.0218 (UTC) FILETIME=[731D3DA0:01C4A51C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> I presume you're not talking about doing swsusp over NFS. If
> so, there's a lot more work to be done to teach the driver
> model and power management infrastructure about the
> dependencies involved to make that a possibility.
> It's safe to say that we don't support that, and won't
> support that at least for some time.

Then let's talk about S3 (suspend to ram), I think it should be
OK with a mounted NFS root, but the firmware issue is still there.

> As far as the firmware goes, there are two choices - reload
> it from userspace once we return or save it memory during
> suspend. I assume that these devices provide some means for
> reading the firmware from them, so you can just allocate a
> buffer and read it into that during the transition.

Agreed. I think now we need a clean interface that makes
drivers, swsusp or even the end user to work together to
finally achieve the goal.

Thanks,
-yi
