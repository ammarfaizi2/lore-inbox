Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264581AbRFYXNz>; Mon, 25 Jun 2001 19:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264582AbRFYXNf>; Mon, 25 Jun 2001 19:13:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6784 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264581AbRFYXN0>;
	Mon, 25 Jun 2001 19:13:26 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15159.50521.360970.127378@pizda.ninka.net>
Date: Mon, 25 Jun 2001 16:12:25 -0700 (PDT)
To: Will <will@egregious.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skb destructor enhancement idea
In-Reply-To: <20010625155016.B17735@egregious.net>
In-Reply-To: <20010618134644.A5938@egregious.net>
	<20010618145331.A32166@wacko.asicdesigners.com>
	<20010621161349.A27654@egregious.net>
	<20010625140613.A17207@egregious.net>
	<15159.48229.326223.682824@pizda.ninka.net>
	<20010625155016.B17735@egregious.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will writes:
 > > Add an ifdef and the knobs you need to the skb struct directly just
 > > like netfilter does.
 > 
 > So I should #ifdef throughout the tcp and socket code wherever skb's 'destructor' is
 > called to call mine as well? And multiply that by N driver writers who'd like to do
 > the same thing? Sounds messy...

Besides low-level packet frobbing, I can't think of any other
application.

In fact, more appropriate would be to extend netfilter to handle
low-level things as well as med/upper level things.

Then we wouldn't need driver specific things, this is my whole
point.  You're designing for yourself and nobody else.  When
people want to add things to sk_buff it usually is for a
not so well thought reason.

Later,
David S. Miller
davem@redhat.com
