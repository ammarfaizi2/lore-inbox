Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270230AbRHHAFs>; Tue, 7 Aug 2001 20:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270231AbRHHAFi>; Tue, 7 Aug 2001 20:05:38 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:47357 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S270230AbRHHAFZ>; Tue, 7 Aug 2001 20:05:25 -0400
To: Jes Sorensen <jes@sunsite.dk>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ? 
In-Reply-To: Your message of "07 Aug 2001 17:09:47 +0200."
             <d33d73x5xg.fsf@lxplus014.cern.ch> 
Date: Wed, 08 Aug 2001 10:05:28 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010808000528.DB146BF02@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Chris> Yes, drivers need to check their hardware devices and
>Chris> acknowledge whether or not it's was their interrupt or not.  It
>Chris> sounds terrible but even with many thousands of interrupts per
>Chris> second the cost doesn't seem to be that high.
>
>Not only is this the case, it's also the only sane thing to do <tm>,
>any device driver should check the status of the hardware it is
>serving before doing anything else.

That's not necessarily the case - the problem arises due the
limitations of PC interrupt routing. In an ideal world, the
interrupting device would be able to be uniquely identified, rather
than having to poll every device sharing that interrupt.

The problem is largely historical - each interrupt traditionally had a
physically line associated with it, and lines on your backplane were a
limited resource. 

If you were to do it again these days, you might have some sort of
shared serial bus, so devices could give detailed data to the cpu
(not only to uniquely identify the interrupting device, but also
identify sub-devices - say a USB peripheral).

 ---
Andrew McNamara (System Architect)

connect.com.au Pty Ltd
Lvl 3, 213 Miller St, North Sydney, NSW 2060, Australia
Phone: +61 2 9409 2117, Fax: +61 2 9409 2111
