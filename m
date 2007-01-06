Return-Path: <linux-kernel-owner+w=401wt.eu-S1751220AbXAFIZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXAFIZO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 03:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbXAFIZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 03:25:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:35143 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXAFIZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 03:25:12 -0500
In-Reply-To: <20070105171735.GA4745@ucw.cz>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <8069085182dff3b0e63a661d81804dbb@kernel.crashing.org> <20070105171735.GA4745@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ea5b255f38ef273251d6af7c8ead65fc@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se, torvalds@osdl.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Sat, 6 Jan 2007 09:23:01 +0100
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For a different mailing list indeed; let me just point
>> out
>> that for certain important quite common cases it's an
>> ~50%
>> overall speedup.
>
> Hmm, what code was that? 'signed int does not wrap around' does not
> seem to provide _that_ much info...

One of the recent huge threads on the GCC dev list has a
post that says *some other* compiler gets a result like
this from this optimisation (I don't have a link to the
exact post and I don't remember the details; perhaps it
was XLC?)

Sorry if I wasn't clear enough and you understood I meant
that GCC exploits this optimisation opportunity well
enough for such nice results already.

  - - -

So I searched for it anyway:

<http://gcc.gnu.org/ml/gcc/2006-12/msg00768.html>

It looks like the result for *integer* code wasn't *all*
that dramatic a difference.  Anyway, it's obvious that
the optimisation can certainly give nice results and it
wouldn't be a good idea for the Linux kernel to dismiss
it without really evaluating the impact first; and anyway,
this is for some future date, GCC-4.2 isn't here yet.


Segher

