Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRKTWL4>; Tue, 20 Nov 2001 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281420AbRKTWLq>; Tue, 20 Nov 2001 17:11:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8076 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281416AbRKTWLh>;
	Tue, 20 Nov 2001 17:11:37 -0500
Date: Tue, 20 Nov 2001 14:11:29 -0800 (PST)
Message-Id: <20011120.141129.57454002.davem@redhat.com>
To: riel@conectiva.com.br
Cc: dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com>
In-Reply-To: <037701c1720a$159ee9a0$1a01a8c0@allyourbase>
	<Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 20 Nov 2001 20:05:05 -0200 (BRST)
   
   Consider this a VM bug, mmap() really should be more efficient.

read() is always going to be faster until mmap() can
use large page mappings for the user.  This is why
mmap() is slower.

Even if the whole thing is cached in memory, read() will
always be faster.
