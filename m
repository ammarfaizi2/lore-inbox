Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbQLIITK>; Sat, 9 Dec 2000 03:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQLIIS7>; Sat, 9 Dec 2000 03:18:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45830 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129675AbQLIISt>; Sat, 9 Dec 2000 03:18:49 -0500
Date: Fri, 8 Dec 2000 23:48:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <200012090541.AAA17863@tsx-prime.MIT.EDU>
Message-ID: <Pine.LNX.4.10.10012082343400.2121-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oh, I forgot to mention: I use a slight modification to your patch: you
left some functions as "__init/__initdata" functions/data even though they
are should definitely be __devinit/__devinitdata for all the hotplug
stuff. So the thing that works for me has had a global search-and-replace
to replace all "__init" with "__devinit".

If you're testing with just modules, you shouldn't see this effect,
though (otherwise you might get strange oopsen and/or corrupted initdata,
of course).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
