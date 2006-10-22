Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422997AbWJVFNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWJVFNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWJVFNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 01:13:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27359 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422997AbWJVFNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 01:13:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BTpeT5CiIkhsSYpUOtgbTpd5WoxScHvEdXy1cG/A8tQ3jf0gJbdX/u3fq4YIVS9FvD3nYKUvDHrAUwNFKLh4HHmtOoRlnK6sxRIlorUM2GHOXiuaNeD3o01fKOBvlTZI+FsHfJHajC5xsbwGd461pFjnrwZANRYkV3w/JovV2kE=
Message-ID: <86802c440610212213g7998fefesc43da2438ad25f01@mail.gmail.com>
Date: Sat, 21 Oct 2006 22:13:45 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <20061022035109.GM5211@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
X-Google-Sender-Auth: 475e2af3b85d4b3f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> On Sat, Oct 21, 2006 at 09:00:17PM +0000, Linux Kernel Mailing List wrote:
> Booting processor 1/4 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 6339.07 BogoMIPS (lpj=12678150)CPU: Trace cache: 12K uops, L1 D cache: Initializing CPU#2
> Calibrating delay using timer specific routine.. 6339.11 BogoMIPS (lpj=12678228)CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 3
> CPU: Processor Core ID: 0
> CPU2: Thermal monitoring enabled (TM1)
>               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
> lockdep: not fixing up alternatives.
> Booting processor 3/4 APIC 0x7
> Initializing CPU#3
> Calibrating delay using timer specific routine.. 6339.20 BogoMIPS (lpj=12678401)CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 3
> CPU: Processor Core ID: 0
> CPU3: Thermal monitoring enabled (TM1)
>               Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
> Brought up 4 CPUs

It seems it tried to initialize CPU2, before CPU1 is all set.

current code still initialize CPU one by one, because there is some
share data structure.

YH
