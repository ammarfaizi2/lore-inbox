Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKKWBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKKWBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVKKWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:01:53 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:11757 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751266AbVKKWBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:01:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/1] cciss: scsi error handling
Date: Fri, 11 Nov 2005 16:01:45 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640A7A5411@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] cciss: scsi error handling
Thread-Index: AcXnCMGbFQ3blLKvS0G2NIBXIfbTqAAAL5y6
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>, <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 11 Nov 2005 22:01:46.0764 (UTC) FILETIME=[825BD4C0:01C5E70B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, the pointers are all held in place.  Even if everyone else releases
> their references, the commmand still contains a reference to the device
> (which holds it from being released) and the device likewise contains a
> reference to the host.

Ok, then I think it's good to go as far as locking is concerned.

Thanks for the explanation.

Regarding the CISS vs. CCISS in the config variable, is that going
to hold up this patch?  I can make a patch to change that, but it's
not really related to this patch, this patch just happens to use 
that config variable.

-- steve


