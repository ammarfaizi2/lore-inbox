Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRCWSfa>; Fri, 23 Mar 2001 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRCWSfM>; Fri, 23 Mar 2001 13:35:12 -0500
Received: from colorfullife.com ([216.156.138.34]:31750 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131262AbRCWSeS>;
	Fri, 23 Mar 2001 13:34:18 -0500
Message-ID: <000d01c0b3c7$e232ae90$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <stelian.pop@fr.alcove.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Use semaphore for producer/consumer case...
Date: Fri, 23 Mar 2001 19:34:07 +0100
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

>      consumer()

>             /* Let's wait for 10 items */
>             atomic_set(&sem->count, -10);

That doesn't work, at least the i386 semaphore implementation doesn't
support semaphore counts < 0.

--
    Manfred

