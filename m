Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267971AbRGZOED>; Thu, 26 Jul 2001 10:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRGZODx>; Thu, 26 Jul 2001 10:03:53 -0400
Received: from mail.phpoint.net ([212.63.10.62]:21129 "EHLO smtp2.koti.soon.fi")
	by vger.kernel.org with ESMTP id <S267971AbRGZODn>;
	Thu, 26 Jul 2001 10:03:43 -0400
From: "M. Tavasti" <tawz@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
In-Reply-To: <Pine.LNX.3.95.1010725114322.520A-100000@chaos.analogic.com> <m2u1zznbcv.fsf@akvavitix.vuovasti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Date: 26 Jul 2001 16:20:31 +0300
In-Reply-To: "M. Tavasti"'s message of "26 Jul 2001 15:06:24 +0300"
Message-ID: <m2n15rn7xc.fsf@akvavitix.vuovasti.com>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"M. Tavasti" <tawz@nic.fi> writes:

> randomly makes select return. When looking from random.c, in 2.2.19
> poll_wait is called once, like this:
> 
> 	poll_wait(file, &random_poll_wait, wait);
> 
> And in 2.4.5:
> 
> 	poll_wait(file, &random_read_wait, wait);
> 	poll_wait(file, &random_write_wait, wait);
> 
> 
> I think I got idea how to do it right, make one wait queue for poll,
> which is woken up when read OR write queue is woken up. 

After testing with my own driver, using just one poll_wait doesn't
make difference in 2.4.5.

-- 
M. Tavasti /  tavastixx@iki.fi  /   +358-40-5078254
 Poista sähköpostiosoitteesta molemmat x-kirjaimet 
     Remove x-letters from my e-mail address
