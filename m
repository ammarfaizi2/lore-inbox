Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281464AbRKTXC3>; Tue, 20 Nov 2001 18:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281467AbRKTXCU>; Tue, 20 Nov 2001 18:02:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33676 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281464AbRKTXCG>;
	Tue, 20 Nov 2001 18:02:06 -0500
Date: Tue, 20 Nov 2001 15:01:54 -0800 (PST)
Message-Id: <20011120.150154.46465259.davem@redhat.com>
To: akpm@zip.com.au
Cc: riel@conectiva.com.br, dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BFAD7EA.136A65A0@zip.com.au>
In-Reply-To: <Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com>
	<20011120.141129.57454002.davem@redhat.com>
	<3BFAD7EA.136A65A0@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Tue, 20 Nov 2001 14:23:38 -0800
   
   Could you please explain further?  What's more expensive
   than the copy?
   
TLB misses add to the cost, and this overhead is more than
"noise".

The Apache guys were playing with using mmap() for page contents
and it was always slower than read() into a static buffer.
