Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbTGIQZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbTGIQZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:25:15 -0400
Received: from fmr02.intel.com ([192.55.52.25]:65475 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268392AbTGIQZK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:25:10 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait
Date: Wed, 9 Jul 2003 09:39:35 -0700
Message-ID: <DC675A50D067E045B80AAEDCBD2648BD02B02E25@fmsmsx408.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait
Thread-Index: AcNGCZaMxxBgA5yUT9Cc84eRkeHbfgALmA/w
From: "Mallick, Asit K" <asit.k.mallick@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 09 Jul 2003 16:39:37.0315 (UTC) FILETIME=[AF81FB30:01C34638]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
Mwait is not dependent directly on the processor and any bus master
write will wake up the mwait. So, your example will also work.
Thanks,
Asit


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Wednesday, July 09, 2003 4:00 AM
> To: Nakajima, Jun
> Cc: Linus Torvalds; Linux Kernel Mailing List; Saxena, Sunil; 
> Mallick, Asit K; Pallipadi, Venkatesh
> Subject: Re: [PATCH] idle using PNI monitor/mwait
> 
> 
> On Maw, 2003-07-08 at 22:23, Nakajima, Jun wrote:
> > Hi Linus,
> > 
> > Attached is a patch that enables PNI (Prescott New Instructions)
> > monitor/mwait in kernel idle (opcodes are now public). 
> Basically MWAIT
> > is similar to hlt, but you can avoid IPI to wake up the processor
> > waiting. A write (by another processor) to the address 
> range specified
> > by MONITOR would wake up the processor waiting on MWAIT.
> 
> Is mwait dependant on cached cpu memory and the cache 
> exclusivity logic
> or directly on the processor. In other words can I use mwait in future
> to wait for DMA to hit a given location ? - Im mostly thinking about
> debugging uses 
> 
> 
