Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSBNAW1>; Wed, 13 Feb 2002 19:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSBNAWS>; Wed, 13 Feb 2002 19:22:18 -0500
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:22261 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289213AbSBNAWG>; Wed, 13 Feb 2002 19:22:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Aaron Lehmann <aaronl@vitelus.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4))
Date: Wed, 13 Feb 2002 19:22:57 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au> <3C65CBDE.A9B60BBD@mandrakesoft.com> <20020213171306.GA15924@vitelus.com>
In-Reply-To: <20020213171306.GA15924@vitelus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020214002205.VBHJ21911.femail34.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 12:13 pm, Aaron Lehmann wrote:
> On Sat, Feb 09, 2002 at 08:24:46PM -0500, Jeff Garzik wrote:
> > It is far easier to guess your private key with a blank passphrase.
>
> I challenge you to present a method for doing so.

Your public/private key pair are pretty straightforward public key 
cryptography.  If you can brute force one given the other, it wouldn't be 
safe to use it over the wire in the first place.

The point of having a passphrase is that some really paranoid people want to 
have both a key AND a password to get into their box.  A password in and of 
itself isn't all that secure, since any human memorizable password contains 
so little information it would be trivial to break computationally via brute 
force (if you can arrange a brute force attack, which login tries to prevent 
with the ~3 second delay between attempts, but they still tend to get written 
down, or people watch keystrokes over your shoulder...).  And a key you carry 
around with you on a floppy or propogate to multiple boxes can be stolen 
(copied) from any of those places without you necessarily knowing about it.

In terms of brute forcing the key, the passphrase adds a fairly trivial 
number of bits to the key.  It's not "far" easer, an 8 character mixed case 
nonsense password with numbers and punctuation mixed in is still less than 6 
bits per character, or at best an extra 48 bits.  You can select a 1024 bit 
key if you want to be really really paranoid.

Not that it's worth it.  Keys get exponentially more difficult to brute force 
as the key length increases.  I read part of a book a long time ago (might 
have been called "applied cryptography") that figured out that if you could 
build a perfectly efficient computer that could do 1 bit's worth of 
calculation with the the amount of energy in the minimal electron state 
transition in a hydrogen atom, and you built a dyson sphere around the sun to 
capture its entire energy output for the however many billion years its 
expected to last, you wouldn't even brute-force exhaust a relatively small 
keyspace (128 bits?  256 bits?  Something like that).

Somebody else here is likely to recognize the above anecdote and give a more 
accurate reference.  Book title and page number would be good...

Rob
