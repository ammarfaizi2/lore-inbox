Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRHUMkv>; Tue, 21 Aug 2001 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271646AbRHUMkj>; Tue, 21 Aug 2001 08:40:39 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:4584 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271645AbRHUMkh>;
	Tue, 21 Aug 2001 08:40:37 -0400
Date: Tue, 21 Aug 2001 13:40:50 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Marco Colombo <marco@esi.it>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <1467527.998401250@[169.254.79.209]>
In-Reply-To: <Pine.LNX.4.33.0108211212570.20625-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.33.0108211212570.20625-100000@Megathlon.ESI>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A little question: I used to believe that crypto software requires
> strong random source to generate key pairs, but this requirement in
> not true for session keys.  You don't usually generate a key pair on
> a remote system, of course, so that's not a big issue. On low-entropy
> systems (headless servers) is /dev/urandom strong enough to generate
> session keys? I guess the little entropy collected by the system is
> enough to feed the crypto secure PRNG for /dev/urandom, is it correct?

I /think/ the answer is 'it depends'.

a) If 'low entropy' meant 'no entropy', then the seed would be the
   same booting one system as on a black-hat identical system.

b) If you can obtain (one way or another) a session key, you can hijack
   that session. Whether or not you can then intercept other sessions
   depends in part what that session is (if, for instance, it is a root
   ssh session...). If you reduce the search space for session keys, you
   make being able to hijack a session considerably easier.

--
Alex Bligh
