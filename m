Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVAJPcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVAJPcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVAJPcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:32:05 -0500
Received: from main.gmane.org ([80.91.229.2]:55188 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262291AbVAJPcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:32:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: /dev/random vs. /dev/urandom
Date: 10 Jan 2005 10:13:18 -0500
Message-ID: <s5ghdlpfifv.fsf@patl=users.sf.net>
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com> <s5gzmzjbza1.fsf@egghead.curl.com> <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: new-new-quasi-lockup.curl.com
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> In the first place, the problem was to display the error of using
> an ANDing operation to truncate a random number.

In the first place, you began by claiming that the number of zero bits
should equal the number of one bits.  I explained how that was wrong,
and now you are saying you meant something else.

Fine, but you are still wrong; it is not an error to use AND.
/dev/random is just a stream of bits.  Each bit behaves like a coin
toss.  When you group the bits into bytes and then AND each byte with
1, you merely examine every eighth bit and throw away the rest.  Each
bit you examine still behaves just like a coin toss.

So ANDing with 1 produces fine output if you are trying to simulate a
fair coin.  Counter to your original claim, the output of your program
is completely consistent with the theory on this.

> In the limit, one could AND with 0 and show that all randomness has
> been removed.

Since that throws away ALL of the bits, of course it "removes the
randomness".  Yes, each byte from /dev/random is a perfectly random
number between 0 and 255.  If you AND with 1, you get a perfectly
random number between 0 and 1.  If you AND with 0, you no longer get a
random number.  Awesome!

> The short number of samples was DELIBERATELY used to exacerbate the
> problem although a number or nay-sayers jumped on this in an attempt
> to prove that I don't know what I'm talking about.

An impression you are reinforcing with every message.  There is
nothing wrong with the randomness from /dev/random, nor with the
odd/even randomness in your sample program's output.  Other than
"trust me", "try it with a real coin", or "read a book", I am not sure
how to convince you of this...  So I will probably stop trying.

 - Pat

