Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129816AbRB0Ugh>; Tue, 27 Feb 2001 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbRB0UgO>; Tue, 27 Feb 2001 15:36:14 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:24079 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129816AbRB0UgE>;
	Tue, 27 Feb 2001 15:36:04 -0500
Envelope-To: linux-kernel@vger.kernel.org
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102271946.TAA00805@raistlin.arm.linux.org.uk>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: davem@redhat.com (David S. Miller)
Date: Tue, 27 Feb 2001 19:46:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15003.34336.1820.574668@pizda.ninka.net> from "David S. Miller" at Feb 27, 2001 02:49:03 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> How do you know this?  There are so many deadly TCP bugs fixed
> since 2.2.15pre13 I don't know how you can assert this.

Through the evidence I gave.  

Firstly, if the receiving side is saying that it has a window of 0, then
it is not going to accept any more data.

Secondly, the receiving side has data waiting in the receive queue.

Thirdly, the receiving process is selecting on the socket, and dispite
there being data waiting, select is saying that there is no data waiting.

All the data is pointing at the 2.4 kernel as being the culprit.

I'm surprised at your response given the amount of hard evidence I gave that
supports my assertion.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

