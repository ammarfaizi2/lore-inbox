Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285200AbRLRVbd>; Tue, 18 Dec 2001 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVaH>; Tue, 18 Dec 2001 16:30:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43269 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285179AbRLRV31>; Tue, 18 Dec 2001 16:29:27 -0500
Date: Tue, 18 Dec 2001 21:28:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
        Mika.Liljeberg@welho.com, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011218212816.G13126@flint.arm.linux.org.uk>
In-Reply-To: <20011218.131155.91757544.davem@redhat.com> <Pine.LNX.4.33L.0112181923030.28489-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0112181923030.28489-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Dec 18, 2001 at 07:24:41PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 07:24:41PM -0200, Rik van Riel wrote:
> On Tue, 18 Dec 2001, David S. Miller wrote:
> > Not necessarily Russell.  You have even told us on several occaisions
> > that the older ARMs simply cannot fix up unaligned loads/stores in
> > fact.
> 
> Then the problem will have to be fixed elsewhere, maybe
> by having the networking code do explicit unaligned
> accesses through some macro which defaults to a normal
> access on other systems ?

It's actually not worth it; these "older ARMs" I believe we can safely
drop from our sights - it has been my intention throughout 2.4 to drop
them out when 2.5 came around.  The problem is that there are people
who do want still use antequated machines, but they can look after
the problems that entails themselves IMHO. 8)

So, as far as 2.5 is concerned, consider all ARMs capable of handling
mis-aligned accesses via a fault handler.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

