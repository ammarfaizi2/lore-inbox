Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272015AbRIDRGs>; Tue, 4 Sep 2001 13:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272019AbRIDRGi>; Tue, 4 Sep 2001 13:06:38 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:24572 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272015AbRIDRG0>;
	Tue, 4 Sep 2001 13:06:26 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15253.2580.147168.364079@napali.hpl.hp.com>
Date: Tue, 4 Sep 2001 10:06:28 -0700
To: Richard Henderson <rth@twiddle.net>
Cc: David Mosberger <davidm@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010904093725.A18163@twiddle.net>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010903131436.A16069@twiddle.net>
	<15251.59286.154267.431231@napali.hpl.hp.com>
	<20010903134125.B16069@twiddle.net>
	<15251.61303.411698.310497@napali.hpl.hp.com>
	<20010904093725.A18163@twiddle.net>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 4 Sep 2001 09:37:25 -0700, Richard Henderson <rth@twiddle.net> said:

  Richard> On Mon, Sep 03, 2001 at 02:00:39PM -0700, David Mosberger
  Richard> wrote:
  >> I didn't think there was any path where the kernel would on its
  >> own update code after the fact, but I could be missing something.

  Richard> ptrace?

ptrace() is handled separately (it's like a user in that sense: it
takes care of establishing coherence by calling the appropriate
flushing routine).

	--david
