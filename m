Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274187AbRISVDP>; Wed, 19 Sep 2001 17:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274189AbRISVDG>; Wed, 19 Sep 2001 17:03:06 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:39354 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S274187AbRISVC4>; Wed, 19 Sep 2001 17:02:56 -0400
Message-ID: <3BA907F6.3586811C@pp.inet.fi>
Date: Thu, 20 Sep 2001 00:02:46 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "steve j. kondik" <shade@chemlab.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
In-Reply-To: <1000912739.17522.2.camel@discord>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"steve j. kondik" wrote:
> i've been using encrypted swap over loopdev using the new cryptoapi
> patches.  i just built a 2.4.10-pre12 kernel and i got a panic doing
> mkswap on the loopdev.  the mkswap process becomes unkillable after this
> and never finishes.  this is repeatable everytime.  i've had no problems
> whatsoever until this kernel even under high load..  any ideas? :>

Cryptoapi can't be used to encrypt swap. It has nasties like sleeping in
make_request_fn() and potential memory allocation deadlock.

loop-AES works with encrypted swap. Announcement is here:

    http://mail.nl.linux.org/linux-crypto/2001-09/msg00006.html
    http://marc.theaimsgroup.com/?l=linux-crypto&m=99953544804810&w=2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

