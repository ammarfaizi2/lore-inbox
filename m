Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266942AbTGGLza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266945AbTGGLza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:55:30 -0400
Received: from rwcrmhc53.comcast.net ([204.127.198.39]:25046 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266942AbTGGLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:55:23 -0400
Subject: Re: C99 types VS Linus types
From: Albert Cahalan <albert@users.sf.net>
To: matthias.andree@gmx.de, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057579305.747.79.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jul 2003 08:01:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree writes:
> On Sun, 06 Jul 2003, Albert Cahalan wrote:

>> Sure, both are "correct", but there would be a lot less
>> pain and suffering in the world if "unsigned long long"
>> would be used for 64-bit.
>
> What if unsigned long long is 96 bit? or 128?

I think you're trolling, but just in case not...

The days of non-power-of-two word sizes are
gone for normal computing. Sign-magnitude and
ones-compliment are dead too. Float is IEEE
format, possibly skipping a few costly features.
Nobody is going to go back to the old way.

It's too bad the C99 committee didn't have the
guts to make this official.

As for 128-bit...

>> It ought to be at least 40 years
>> before 128-bit types begin to matter.
>
> Yup, and 8-Bit CPU and 640 kB RAM ought to be enough for...
>
> nevermind.

There's a logrithmic/exponential thing going on.
Measuring bits isn't like measuring kB. It's log(kB),
which interacts with Moore's law to give a plain
linear need for bits. It took about 20 years to eat
through the extra bits we got with 32-bit CPUs. Now
we have twice as many bits to eat through. So that's
40 years right there. People will make do for much
longer though; notice that 8-bit was never comfy
while 32-bit was.

>> In the Linux world,
>> we can consider "long long" to be 64-bit, "int" to be
>> 32-bit, and "long" to be the same size as a pointer. 
>> Then we can ditch the nasty casts:
>> sprintf(foo, "%llu", (unsigned long long)bar);
>
> Speaking of shifting forward to standards:
>
> unsigned char foo = 42;
> char bar[42];
> sprintf(bar, "%ju", (uintmax_t)foo); // see IEEE Std 1003.1-2001
>
> If that's too ugly, write your own [u]intmax_t-to-char[]
> converter, then only the stack is nasty if uintmax_t is 128
> bits wide and you're printing an array uint8_t. :-P

Yes, that is too ugly. It's idealistic code.
Readability matters more than worrying about
something which won't happen for over 40 years,
and won't cause Y2K-style problems even then.

If I live that long, I'll need employment anyway.

Perfection is the enemy of good. In practice,
there is a difference between theory and practice.
Etc.


