Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRKTXkj>; Tue, 20 Nov 2001 18:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281267AbRKTXk3>; Tue, 20 Nov 2001 18:40:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60812 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281162AbRKTXkZ>;
	Tue, 20 Nov 2001 18:40:25 -0500
Date: Tue, 20 Nov 2001 15:40:04 -0800 (PST)
Message-Id: <20011120.154004.123980549.davem@redhat.com>
To: riel@conectiva.com.br
Cc: akpm@zip.com.au, dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0111202134550.4079-100000@imladris.surriel.com>
In-Reply-To: <20011120.150154.46465259.davem@redhat.com>
	<Pine.LNX.4.33L.0111202134550.4079-100000@imladris.surriel.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 20 Nov 2001 21:35:40 -0200 (BRST)

   On Tue, 20 Nov 2001, David S. Miller wrote:
   > TLB misses add to the cost, and this overhead is more than
   > "noise".
   
   Well, this could have something to do with the fact
   that our page fault handler only maps in _1_ page at
   a time, so we're trapping into the pagefault handler
   every 4kB...

The Apache folks were keeping it mapped across requests,
so even if it was "primed" (ie. pre-faulted), a read() into
a static buffer was still significantly faster.
