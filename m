Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293580AbSBZU5p>; Tue, 26 Feb 2002 15:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293542AbSBZU5g>; Tue, 26 Feb 2002 15:57:36 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:27891 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S292555AbSBZU50>;
	Tue, 26 Feb 2002 15:57:26 -0500
To: Patrick Cole <z@amused.net>
Cc: Dennis Schoen <dennis@cobolt.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG]: RT8139 Too much work at interrupt, IntrStatus=....
In-Reply-To: <20020109090855.GA338@cobolt.net> <20020219055243.GA4398@jaded.anu.edu.au>
From: Jes Sorensen <jes@sunsite.dk>
Date: 26 Feb 2002 21:57:05 +0100
In-Reply-To: Patrick Cole's message of "Tue, 19 Feb 2002 16:52:43 +1100"
Message-ID: <d3elj8ufku.fsf@lxplus049.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Cole <z@amused.net> writes:

> Hi dennis, I'm getting these messages too with an identical card... 
> 8139 (rev 10)... seems to have started happening after I went to
> 2.4.17... strangely enough I'm getting very similar mæssages on the
> machine right beside it.. running 2.4.13, SMP, and a 3com 3c905b
> (Boomerang).

The problem with the 8139 is the fact that the chip design is really
dumb, when I say dumb here, I mean *really* dumb ;-(

The result is that when the card is bombarded with a lot of small
packets it can livelock because the queues fill up faster than the
kernel code can empty and process them.

I made some changes to improve the situation in the driver, for 2.2
kernels, which I have submitted to Jeff and he plans to integrated
them into the next release.

My patched drivers are available from
http://www.wildopensource.com/proj/download/SG_drivers.html however I
haven't tested them on 2.4.x, so I am not going to bet on them
working.

Cheers,
Jes
