Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbRFYWul>; Mon, 25 Jun 2001 18:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264569AbRFYWub>; Mon, 25 Jun 2001 18:50:31 -0400
Received: from tyranny.egregious.net ([206.159.99.12]:61704 "HELO
	tyranny.egregious.net") by vger.kernel.org with SMTP
	id <S263246AbRFYWuX>; Mon, 25 Jun 2001 18:50:23 -0400
Date: Mon, 25 Jun 2001 15:50:16 -0700
From: Will <will@egregious.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skb destructor enhancement idea
Message-ID: <20010625155016.B17735@egregious.net>
In-Reply-To: <20010618134644.A5938@egregious.net> <20010618145331.A32166@wacko.asicdesigners.com> <20010621161349.A27654@egregious.net> <20010625140613.A17207@egregious.net> <15159.48229.326223.682824@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15159.48229.326223.682824@pizda.ninka.net>; from davem@redhat.com on Mon, Jun 25, 2001 at 03:34:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I think the idea totally stinks.

The idea, or just the performance implications of my particular implementation? If
this could be done without a global spinlock would you still object to the
construction of the small linked list in each skb?

> Add an ifdef and the knobs you need to the skb struct directly just
> like netfilter does.

So I should #ifdef throughout the tcp and socket code wherever skb's 'destructor' is
called to call mine as well? And multiply that by N driver writers who'd like to do
the same thing? Sounds messy...

-- 
-Will  :: AD6XL :: http://tyranny.egregious.net/~will/
 Orton :: finger will@tyranny.egregious.net for GPG public key
