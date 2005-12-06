Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVLFMGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVLFMGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLFMGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:06:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61907 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964952AbVLFMGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:06:48 -0500
From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Date: Tue, 6 Dec 2005 13:06:36 +0100
Message-ID: <000101c5fa5d$863f3900$0a016696@EW10>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20051206112900.GA29790@elte.hu>
Thread-Index: AcX6WI9ojNcovxfdRPakOC7/BfBPmQABGhHw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:79a9c929f10b28b00e544b1aedb42267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * David Engraf <engraf.david@netcom-sicherheitstechnik.de> wrote:
> 
> > > (and.. wait.. isn't that called gettimeofday() )
> >
> > Not really gettimeofday is based on the date and time, but what if the
> > user changes the date, the counter would also change.
> 
> see 'man clock_gettime', and CLOCK_MONOTONIC:
> 
>        CLOCK_MONOTONIC
>               Clock that cannot be set and  represents  monotonic  time
> since
>               some unspecified starting point.
> 
> and it has microsecond resolution.
> 
> 	Ingo

You're right, clock_gettime with CLOCK_MONOTONIC seems to be date/time
independent. For a GetTickCount implementation it is absolutely enough.

Thanks
David Engraf


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2039 from 06.12.2005
Virus news: www.antiviruslab.com

