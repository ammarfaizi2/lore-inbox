Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132470AbRCZROD>; Mon, 26 Mar 2001 12:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRCZRNx>; Mon, 26 Mar 2001 12:13:53 -0500
Received: from colorfullife.com ([216.156.138.34]:14345 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132470AbRCZRNm>;
	Mon, 26 Mar 2001 12:13:42 -0500
Message-ID: <007d01c0b618$040b1780$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Stelian Pop" <stelian.pop@fr.alcove.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000d01c0b3c7$e232ae90$5517fea9@local> <20010326165425.G15689@come.alcove-fr>
Subject: Re: Use semaphore for producer/consumer case...
Date: Mon, 26 Mar 2001 19:12:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stelian Pop" <stelian.pop@fr.alcove.com>
> >
> > That doesn't work, at least the i386 semaphore implementation
doesn't
> > support semaphore counts < 0.
>
> Does that mean that kernel semaphore can not be used for something
> else than mutual exclusion ?
>
It's a bit better: counts >= 0 are supported, i.e. you can call up()
before down(), and that's used in several places.

The for loop that Nigel proposed should solve your problem. Multiple
up's are handled correctly.

--
    Manfred

