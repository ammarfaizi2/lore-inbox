Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBTXck>; Tue, 20 Feb 2001 18:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRBTXcV>; Tue, 20 Feb 2001 18:32:21 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:45585 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S129107AbRBTXcL>;
	Tue, 20 Feb 2001 18:32:11 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102202332.f1KNW8S02052@oboe.it.uc3m.es>
Subject: Re: plugging in 2.4. Does it work?
In-Reply-To: <20010220235813.B811@suse.de> from "Jens Axboe" at "Feb 20, 2001
 11:58:13 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Wed, 21 Feb 2001 00:32:08 +0100 (MET)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> Forgot to mention that the above doesn't make much sense at all. If
> there are no errors, you loop through ending all the buffers. Then

Yes, that's right, thanks. I know I do one more end_that_request_first
than is necessary, but it is harmless as there is a guard in the 
kernel code. At least, it's harmless until someone removes that guard.

It is like that because I added the while loop to the front of the code I
already had working when I decided to try plugging.

> you fall through and end the the first (non-existant) chunk? And
> end_that_request_first does not need to hold the io_request_lock,
> you can move that down to protect end_that_request_last.

OK, thanks!

Peter
