Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263967AbRFMPHO>; Wed, 13 Jun 2001 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263976AbRFMPGy>; Wed, 13 Jun 2001 11:06:54 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:16239 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S263967AbRFMPGt>;
	Wed, 13 Jun 2001 11:06:49 -0400
Date: Wed, 13 Jun 2001 09:06:12 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: Philips <philips@iph.to>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: threading question
In-Reply-To: <3B27760F.41A0635D@iph.to>
Message-ID: <Pine.LNX.4.30.0106130905120.23896-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solaris has pset_create() and pset_bind() where you can bind LWPs to
specific processors, but I doubt this works on anything else....

Best regards,
Ognen

On Wed, 13 Jun 2001, Philips wrote:

> 	BTW.
> 	Question was poping in my mind and finally got negative answer by my mind ;-)
>
> 	Is it possible to make somethis like:
>
>
> 	char a[100] = {...}
> 	char b[100] = {...}
> 	char c[100];
> 	char d[100];
>
> 	1: { // run this on first CPU
> 		for (int i=0; i<100; i++) c[i] = a[i] + b[i];
> 	};
> 	2: { // run this on any other CPU
> 		for (int i=0; i<100; i++) d[i] = a[i] * b[i];
> 	};
>
> 	...
> 	// do something else...
> 	...
>
> 	wait 1,2; // to be sure c[] and d[] are ready.
>
>
> 	what was popping in my mind - some prefix (like 0x66 Intel used for 32
> instructions) to say this instruction should run on other CPU?
> 	I know - stupid idea. Too many questions will arise.
> 	If we will do
>
> 	PREFIX jmp far some_routing
>
> 	and this routing will run on other CPU not blocking current execution thread.
> 	(who will clean stack? when?.. question without answers...)
>
> 	Is there anything like this in computerworld? I heard about old computers that
> have a speacial instruction set to implicit run code on given processor.
> 	Is it possible to emulate this behavior on PCs?

-- 
Ognen Duzlevski
Plant Biotechnology Institute
National Research Council of Canada
Bioinformatics team

