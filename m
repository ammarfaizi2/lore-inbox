Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSFEKdC>; Wed, 5 Jun 2002 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFEKdB>; Wed, 5 Jun 2002 06:33:01 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:12816 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S314529AbSFEKdA>; Wed, 5 Jun 2002 06:33:00 -0400
Date: Wed, 5 Jun 2002 11:41:49 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Karim Yaghmour <karim@opersys.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020605114149.R681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E17FQPj-0001Rr-00@starship> <Pine.LNX.4.44.0206042132450.2614-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 09:40:25PM -0500, Oliver Xymoron wrote:
> Just bear in mind that it's next to impossible to avoid throwing the baby
> out with the bathwater here. Ok, so you've got an RT kernel playing your
> MP3 alongside your UNIX system - how do you control it? How do you switch
> tracks? All the latency that you were struggling with in the player is
> still there in the user interface.
 
What stops you from providing non-sleeping messaging scheme
primitives in Adeos? 

Adeos -> Client: Use virtual interrupt vectors and use your ipipe
   for it.

Client -> Adeos: Provide Emission of this virtual interrupts in
Adeos.

Also some kind of shared memory and a "commit" for this memory is
needed in Adeos. Allocation of this memory should be up to the
requester of this memory, so Adeos doesn't need to wait for it
and neither does the RTOS on the other end.

With that primitives (plus some atomic magic ;-)) you can build
non-sleeping messaging.

Karim, is sth. like this planned or is it senseless?

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
