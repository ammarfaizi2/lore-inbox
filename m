Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273731AbRIQWkp>; Mon, 17 Sep 2001 18:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRIQWke>; Mon, 17 Sep 2001 18:40:34 -0400
Received: from colorfullife.com ([216.156.138.34]:48134 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273731AbRIQWk1>;
	Mon, 17 Sep 2001 18:40:27 -0400
Message-ID: <003b01c13fc9$d04a4830$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Robert Love" <rml@tech9.net>, "Roger Larsson" <roger.larsson@norran.net>,
        <linux-kernel@vger.kernel.org>, <nigel@nrg.org>
In-Reply-To: <000901c138bbe151270/mnt/sendme10411ac@local> <1000007070.836.14.camel@phantasy> <001a01c1390262c7f30/mnt/sendme10411ac@local> <20010914091558.A35@toy.ucw.cz>
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
Date: Tue, 18 Sep 2001 00:40:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> is it legal to kmap_atomic(a,b); kmap_atomic(c,d); kunmap_atomic(a,b);
?
>
Yes, that's legal - just think about one kmap_atomic from process
context, and another one in irq context.

> If so, your patch may need some ounting....
> Pavel

I hope ctx_sw_off does internal counting, correct?

--
    Manfred

