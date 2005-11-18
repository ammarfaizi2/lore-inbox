Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVKRMwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVKRMwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbVKRMwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:52:07 -0500
Received: from us01smtp1.synopsys.com ([198.182.44.79]:18687 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S1161088AbVKRMwF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:52:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Does Linux has File Stream mapping support...?
Date: Fri, 18 Nov 2005 18:21:59 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Does Linux has File Stream mapping support...?
Thread-Index: AcXsO8jtdA+wMx7xTNml/n+jL9xOKQAAlpiw
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <7eggert@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2005 12:52:04.0100 (UTC) FILETIME=[E00CF440:01C5EC3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ye...I know of tee.

But the issue here is I have a HUGE Compiler (an Simulation tool) in which thousands of places there are "printf" statements to print messages to STDOUT stream. Now, a requirement came up which needs all those messages thrown to STDOUT also to be logged in a LOGFILE (in addition to STDOUT). Yes, this can be done through tee...but the usage model of the compiler doesn't leave that possibility open for me. 

So, am looking for a solution inside the Compiler code.

Thanks,
Arijit

-----Original Message-----
From: Bodo Eggert [mailto:harvested.in.lkml@7eggert.dyndns.org] 
Sent: Friday, November 18, 2005 6:00 PM
To: Arijit Das; linux-kernel@vger.kernel.org
Subject: Re: Does Linux has File Stream mapping support...?

Arijit Das <Arijit.Das@synopsys.com> wrote:

> Is it possible to have File Stream Mapping in Linux? What I mean is
> this...
> 
> FILE * fp1 = fopen("/foo", "w");
> FILE * fp2 = fopen("/bar", "w");
> FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
> 
> fprint(fp_common, "This should be written to both files ... /foo and
> /bar");

It's a userspace problem. man "tee".

Doing this in the kernel would be horrible.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
