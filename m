Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314295AbSEMRyP>; Mon, 13 May 2002 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314358AbSEMRyO>; Mon, 13 May 2002 13:54:14 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:35523 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314295AbSEMRyM>;
	Mon, 13 May 2002 13:54:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15583.64945.895937.416115@napali.hpl.hp.com>
Date: Mon, 13 May 2002 10:53:53 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Rusty Russell <rusty@rustcorp.com.au>,
        <engebret@vnet.ibm.com>, <justincarlson@cmu.edu>,
        <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <anton@samba.org>, <ak@suse.de>, <paulus@samba.org>
Subject: Re: Memory Barrier Definitions
In-Reply-To: <Pine.LNX.4.44.0205130938380.19524-100000@home.transmeta.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 13 May 2002 09:50:01 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> Until ia64 is a noticeable portion of the installed base, and
  Linus> indeed, until it has shown that it can survive at all, we're
  Linus> not going to design the Linux SMP memory ordering around that
  Linus> architecture.

Well, I hope we can *discuss* ideas for models that could accommodate
all platforms.

  Linus> We're _not_ going to make up a complicated, big fancy new
  Linus> model. We might tweak the current one a bit. And if that
  Linus> means that some architectures get heavier barriers than they
  Linus> strictly need, then so be it. There are two overriding
  Linus> concerns:

  Linus>  - sanity: maybe it's better to have one mb() that is a
  Linus> sledgehammer but obvious, than it is to have many subtle
  Linus> variations that are just asking for subtle bugs.

I tend to agree.

  Linus>  - x86 _owns_ the market right now, and we're not going to
  Linus> make up barriers that add overhead to x86. We may add
  Linus> barriers that end up being no-op's on x86 (because it is
  Linus> fairly ordered anyway), but basically it should be designed
  Linus> for the _common_ case, not for some odd-ball architecture
  Linus> that has sold machines mostly for test purposes.

Nobody suggested such a thing.

  Linus> The x86 situation is obviously just today. In five or ten
  Linus> years maybe everybody agrees that we should follow the ia-64
  Linus> model, and x86 can do strange things that end up being slow.

Geez, how about we spend a little time thinking about it *now*?
Perhaps Rusty can come up with a model that will be easy to program
for *and* work well for all platforms.  Wouldn't that be neat?  If
not, we can always fall back on the sledge hammer (unlike other
platforms, ia64 performance isn't affected much be extraneous memory
barriers).

	--david
