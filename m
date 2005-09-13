Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVIMVyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVIMVyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVIMVyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:54:16 -0400
Received: from magic.adaptec.com ([216.52.22.17]:43178 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751053AbVIMVyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:54:15 -0400
Message-ID: <43274A7F.20002@adaptec.com>
Date: Tue, 13 Sep 2005 17:54:07 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org> <43273E6C.9050807@adaptec.com> <432746A0.50402@s5r6.in-berlin.de>
In-Reply-To: <432746A0.50402@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 21:54:13.0491 (UTC) FILETIME=[ADD09C30:01C5B8AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 17:37, Stefan Richter wrote:
> Luben Tuikov wrote:
> 
>>I've never seen the symbols "lun".
> 
> 
> It is merely an encoding of a variable name or struct member name 
> according to the coding style spec.

I appreciate your insight.

I've never seen a "lun" in _any_ spec.  It is always abbreviated
"LUN".

"lun" exists only in the SCSI Core.  Even other OSs use "LUN".

So after a while, after someone reads enough specs, they see
only "LUN".  "lun" seems foreign.

> 
>>"task->ssp_task.LUN"
> 
> 
> But SSP is a TLA too, isn't it? ;-)

Not quite.  I can actually _see_ "LUN" in the frame.

As I said, after a while it becomes second nature to you,
due to the layout of the frame you're working with.

The pattern that the brain sees is "LUN": in the
transport frame and in the code.

	Luben

P.S. Trust me, using "lun" would be quite ugly and it would
show that whoever coded it has had little experience reading
SCSI specs.  What you want to use is "u8 LUN[8]".

PPS. I hope I don't have to put up this sort of convincing
emails back and forth for each and every little thing.  We'd
get nowhere, no code will be written and no hardware would
work.


