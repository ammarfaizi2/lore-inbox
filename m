Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281507AbRKUAWL>; Tue, 20 Nov 2001 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKUAWD>; Tue, 20 Nov 2001 19:22:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25485 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281507AbRKUAVp>;
	Tue, 20 Nov 2001 19:21:45 -0500
Date: Tue, 20 Nov 2001 16:21:32 -0800 (PST)
Message-Id: <20011120.162132.25418218.davem@redhat.com>
To: riel@conectiva.com.br
Cc: akpm@zip.com.au, dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0111202218360.4079-100000@imladris.surriel.com>
In-Reply-To: <20011120.154004.123980549.davem@redhat.com>
	<Pine.LNX.4.33L.0111202218360.4079-100000@imladris.surriel.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 20 Nov 2001 22:19:26 -0200 (BRST)

   On Tue, 20 Nov 2001, David S. Miller wrote:
   > The Apache folks were keeping it mapped across requests,
   > so even if it was "primed" (ie. pre-faulted), a read() into
   > a static buffer was still significantly faster.
   
   Interesting.  I wonder how read() and mmap() compare when the
   data is in highmem pages and we're facing a kmap()/kunmap()
   for read() ...

Probably, the performance drops for read() to be equivalent,
or slightly below, mmap() peformance.  That would be my guess.

Franks a lot,
David S. Miller
davem@redhat.com
