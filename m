Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWGFLrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWGFLrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWGFLrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:47:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:52573 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965184AbWGFLrY convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:47:24 -0400
X-IronPort-AV: i="4.06,212,1149490800"; 
   d="scan'208"; a="94006962:sNHT18504752"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Thu, 6 Jul 2006 15:47:18 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06D184@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagcG9P/vEEghgGT6ORznqVy8jSGAAgAQHA
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jul 2006 11:47:23.0362 (UTC) FILETIME=[F1F5D420:01C6A0F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If this change has any effect at all, then maximal number of pdflush
> threads has been started.

I have not observed more than 2 pdflush after patching.
User thread is not stopped. The thread pdflush starts writing-out dirty
pages after low dirty level is reached. User thread continues its own
functions concurrently while high dirty limit is not reached.

Leonid

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Thursday, July 06, 2006 12:14 AM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > I have added proposed by Nikita lines
 > 		if (pdflush_operation(background_writeout, 0))
 >                 writeback_inodes(&wbc);
 > and tested it with iozone. The throughput is 50-53 MB/sec. It is less
 > than 74-105 MB/sec results sent earlier.

If this change has any effect at all, then maximal number of pdflush
threads has been started. But there is only one device, so what are
these threads doing?

 > 
 > Leonid

Nikita.
