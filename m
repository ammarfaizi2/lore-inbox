Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263988AbRFJGqM>; Sun, 10 Jun 2001 02:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264504AbRFJGqC>; Sun, 10 Jun 2001 02:46:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59274 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264503AbRFJGpu>;
	Sun, 10 Jun 2001 02:45:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15139.6030.237198.508845@pizda.ninka.net>
Date: Sat, 9 Jun 2001 23:45:34 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
Cc: Riley Williams <rhw@MemAlpha.CX>, Adrian Cox <adrian@humboldt.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable endianess problem in TLAN driver 
In-Reply-To: <26927.992129768@redhat.com>
In-Reply-To: <15138.44403.815959.756121@pizda.ninka.net>
	<15138.42357.146305.892652@pizda.ninka.net>
	<Pine.LNX.4.33.0106092356360.23184-100000@infradead.org>
	<26927.992129768@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Woodhouse writes:
 > davem@redhat.com said:
 > > Riley Williams writes:
 > >  > Even if that wasn't true, aren't the above all self-recursive
 > >  > definitions that would prevent anything calling them from compiling?
 > 
 > > Yes, it looks that way. 
 > 
 > cpp doesn't recurse. 

My bad.  What I actually mean is that it simply wouldn't work.
They'd have to do something like drivers/net/eepro100.c does
(grep for "#ifndef USE_IO").

Later,
David S. Miller
davem@redhat.com
