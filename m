Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271820AbRICVAp>; Mon, 3 Sep 2001 17:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRICVAf>; Mon, 3 Sep 2001 17:00:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:41443 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S271820AbRICVAX>;
	Mon, 3 Sep 2001 17:00:23 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.61303.411698.310497@napali.hpl.hp.com>
Date: Mon, 3 Sep 2001 14:00:39 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: David Mosberger <davidm@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010903134125.B16069@twiddle.net>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010903131436.A16069@twiddle.net>
	<15251.59286.154267.431231@napali.hpl.hp.com>
	<20010903134125.B16069@twiddle.net>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 3 Sep 2001 13:41:25 -0700, Richard Henderson <rth@twiddle.net> said:

  Richard> You can get a missed flush from

  Richard> 	bit == 0 flush cache

  Richard> 				modify page bit = 0

  Richard> 	bit = 1

  Richard> unless this is protected from some outer lock of which I am
  Richard> not aware.

  Richard> I do see your point about the early set though.

I didn't think there was any path where the kernel would on its own
update code after the fact, but I could be missing something.  Note,
that if it's the user's doing, the user is responsible for ensuring
coherence.

	--david
