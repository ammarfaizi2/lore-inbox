Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSKHTVo>; Fri, 8 Nov 2002 14:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbSKHTVo>; Fri, 8 Nov 2002 14:21:44 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:29691 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262250AbSKHTVl>;
	Fri, 8 Nov 2002 14:21:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.4071.102881.673519@napali.hpl.hp.com>
Date: Fri, 8 Nov 2002 11:26:31 -0800
To: Matthew Wilcox <willy@debian.org>
Cc: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "''Linus Torvalds ' '" <torvalds@transmeta.com>,
       "''Jeremy Fitzhardinge ' '" <jeremy@goop.org>,
       "''William Lee Irwin III ' '" <wli@holomorphy.com>,
       "''linux-ia64@linuxia64.org ' '" <linux-ia64@linuxia64.org>,
       "''Linux Kernel List ' '" <linux-kernel@vger.kernel.org>,
       "''rusty@rustcorp.com.au ' '" <rusty@rustcorp.com.au>,
       "''dhowells@redhat.com ' '" <dhowells@redhat.com>,
       "''mingo@elte.hu ' '" <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
In-Reply-To: <20021108191907.N12011@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4EE@usslc-exch-4.slc.unisys.com>
	<20021108191907.N12011@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 8 Nov 2002 19:19:07 +0000, Matthew Wilcox <willy@debian.org> said:

  Matthew> On Fri, Nov 08, 2002 at 12:05:30PM -0600, Van Maren, Kevin
  Matthew> wrote:
  >> Absolutely you should minimize the locking contention.  However,
  >> that isn't always possible, such as when you have 64 processors
  >> contending on the same resource.

  Matthew> if you've got 64 processors contending on the same
  Matthew> resource, maybe you need to split that resource up so they
  Matthew> can have a copy each.  all that cacheline bouncing can't do
  Matthew> your numa boxes any good.

Matthew, please understand that this is NOT a performance problem.
It's a correctness problem.  If livelock can resolut from read-write locks,
it's a huge security problem.  Period.

	--david
