Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSH0UbC>; Tue, 27 Aug 2002 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSH0UbC>; Tue, 27 Aug 2002 16:31:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17809 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315265AbSH0UbB>;
	Tue, 27 Aug 2002 16:31:01 -0400
Date: Tue, 27 Aug 2002 13:29:44 -0700 (PDT)
Message-Id: <20020827.132944.123972162.davem@redhat.com>
To: ak@suse.de
Cc: dcn@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: atomic64_t proposal
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73sn102hvu.fsf@oldwotan.suse.de>
References: <200208271937.OAA78345@cyan.americas.sgi.com.suse.lists.linux.kernel>
	<p73sn102hvu.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 27 Aug 2002 21:58:45 +0200

   If yes, the implementation on 32bit could be a problem. e.g. some 
   archs need space in there for spinlocks, so it would be needed to limit
   the usable range.

x86 would need 1 bit, some other 32-bit platforms would be ok
with just a byte (ie. 8 bits).

I don't like this whole transparent idea just like you Andi.

People should ask for the types they want, if they want 64-bits
of counter, they should explicitly use atomic64_t and use the
atomic64_t operations on that type.
