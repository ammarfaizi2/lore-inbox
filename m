Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWEPVM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEPVM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWEPVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:12:56 -0400
Received: from mail0.lsil.com ([147.145.40.20]:15338 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750835AbWEPVMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:12:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 15:12:51 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD86@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help: strange messages from kernel on IA64 platform
Thread-Index: AcZ5K7zvpC6zXIW4ShqByfERQdSNcAAASG9w
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Chase Venters" <chase.venters@clientec.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2006 21:12:52.0192 (UTC) FILETIME=[7E0D2E00:01C6792D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tuesday, May 16, 2006 5:00 PM, Chase Venters wrote:
> It's a trap, which means the CPU is effectively calling that 
> function.
O.K, that's why...
Then, Is there anyway to look up trap table that the CPU has?
> My best suggestion is to figure out what data is at 
> 0xe00000007f3d80dc and 
> what instructions are at 0xa0000002000373b1.
I will try as you suggested.
Thank you very much for comment.

Regards,

> -----Original Message-----
> From: Chase Venters [mailto:chase.venters@clientec.com] 
> Sent: Tuesday, May 16, 2006 5:00 PM
> To: Ju, Seokmann
> Cc: Linux Kernel Mailing List; linux-scsi@vger.kernel.org
> Subject: Re: Help: strange messages from kernel on IA64 platform
> 
> On Tue, 16 May 2006, Ju, Seokmann wrote:
> 
> > Hi,
> >
> > During communication in between application and megaraid driver via
> > IOCTL, the system displays messages which are not easy to 
> track down.
> > Following is one of the messages and same messages with 
> different values
> > are poping up regularly.
> > ---
> > Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
> > ---
> >
> > I understand the kernel is complaining about the address 
> which is not
> > aligned and, found the message is coming from function
> > 'ia64_handle_unaligned()' in the arch/ia64/kernel/unaligned.c.
> > But, I couldn't find who is calling this function and 
> further details of
> > reasons.
> >
> > Where should I start to figure out it?
> 
> It's a trap, which means the CPU is effectively calling that 
> function. My 
> best suggestion is to figure out what data is at 
> 0xe00000007f3d80dc and 
> what instructions are at 0xa0000002000373b1.
> 
> > Thank you,
> >
> > Seokmann
> 
> Thanks,
> Chase
> 
