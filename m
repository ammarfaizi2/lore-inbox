Return-Path: <linux-kernel-owner+w=401wt.eu-S932879AbWLNRb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWLNRb0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932884AbWLNRb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:31:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:44553 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932879AbWLNRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:31:25 -0500
Date: Thu, 14 Dec 2006 18:17:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alan <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>,
       Hua Zhong <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <1166101830.27217.1037.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0612141815100.12730@yvahk01.tjqt.qr>
References: <4580E37F.8000305@mbligh.org>  <003801c71f45$45d722c0$6721100a@nuitysystems.com>
  <20061214111439.11bed930@localhost.localdomain>  <200612141231.17331.hjk@linutronix.de>
  <20061214124241.44347df6@localhost.localdomain> 
 <Pine.LNX.4.61.0612141354410.6223@yvahk01.tjqt.qr>
 <1166101830.27217.1037.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1895033763-1166116628=:12730"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1895033763-1166116628=:12730
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 14 2006 14:10, Arjan van de Ven wrote:
>On Thu, 2006-12-14 at 13:55 +0100, Jan Engelhardt wrote:
>> >On Thu, 14 Dec 2006 12:31:16 +0100
>> >Hans-Jürgen Koch wrote:
>> >
>> >You think its any easier to debug because the code now runs in ring 3 but
>> >accessing I/O space.
>> 
>> A NULL fault won't oops the system,
>
>.. except when the userspace driver crashes as a result and then the hw
>still crashes the hw (for example via an irq storm or by tying the PCI
>bus or .. )

hw crashes the hw? Anyway, yes it might happen, the more with non-NULL pointers
(dangling references f.ex.)
However, if the userspace part is dead, no one acknowledges the irq, hence an
irq storm (if not caused by writing bogus stuff into registers) should not
happen.
>
>

	-`J'
-- 
--1283855629-1895033763-1166116628=:12730--
