Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbQLCAFq>; Sat, 2 Dec 2000 19:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbQLCAF0>; Sat, 2 Dec 2000 19:05:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46315 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130648AbQLCAFP>;
	Sat, 2 Dec 2000 19:05:15 -0500
Date: Sat, 2 Dec 2000 18:34:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, david@linux.com,
        linux-kernel@vger.kernel.org, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <200012022318.SAA17498@tsx-prime.MIT.EDU>
Message-ID: <Pine.GSO.4.21.0012021830090.28923-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Theodore Y. Ts'o wrote:

> particularly people who writing network programs.  The number of people
> who assume that they can get an entire (variable-length) RPC packet by
> doing a single read() call astounds me.  TCP doesn't provide message
> boundaries, never did and never will.  The problem is that such program
> will work on a LAN, and then blow up when you try using them across the
> real Internet.

Erm... Not that ignoring the return values was a bright idea, but the
lack of reliable ordered datagram protocol in IP family is not a good
thing. It can be implemented over TCP, but it's a big overkill. IL is a
nice thing to have...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
