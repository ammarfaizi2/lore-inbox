Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSHBQgh>; Fri, 2 Aug 2002 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSHBQev>; Fri, 2 Aug 2002 12:34:51 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62454 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315442AbSHBQep>;
	Fri, 2 Aug 2002 12:34:45 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.46452.806917.37660@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 09:38:12 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd()
In-Reply-To: <1028310567.18635.87.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
	<1028310567.18635.87.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 02 Aug 2002 18:49:27 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> I can't think of anything cachable with nasty side effects we
  Alan> might encounter right now but one day someone will do it just
  Alan> to be annoying.

Cacheable and side-effects don't go together.  Even without explicit
software prefetches, most modern CPUs will happily and aggressively
prefetch stuff from cacheable translations.

That's (partly) why we have this strange situation where execution in
virtual address space is actually _faster_ than in physical space,
even though the former involves more work per memory access.

	--david
