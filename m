Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285219AbRLRVhn>; Tue, 18 Dec 2001 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVgQ>; Tue, 18 Dec 2001 16:36:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7315 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285203AbRLRVe6>;
	Tue, 18 Dec 2001 16:34:58 -0500
Date: Tue, 18 Dec 2001 13:33:38 -0800 (PST)
Message-Id: <20011218.133338.122061979.davem@redhat.com>
To: riel@conectiva.com.br
Cc: rmk@arm.linux.org.uk, kuznet@ms2.inr.ac.ru, Mika.Liljeberg@welho.com,
        Mika.Liljeberg@nokia.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0112181923030.28489-100000@duckman.distro.conectiva>
In-Reply-To: <20011218.131155.91757544.davem@redhat.com>
	<Pine.LNX.4.33L.0112181923030.28489-100000@duckman.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 18 Dec 2001 19:24:41 -0200 (BRST)
   
   Then the problem will have to be fixed elsewhere, maybe
   by having the networking code do explicit unaligned
   accesses through some macro which defaults to a normal
   access on other systems ?

It is a port requirement to fix up such accesses.  It has always been
a port requirement to fix up such accesses, and it isn't going to
change.

If I fix up TCP options, I'd have to fixup every access to every
single networking header in the entire stack because "protocol in
protocol" cases can cause unaligned accesses to happen just about any
place.
