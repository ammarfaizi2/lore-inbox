Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315819AbSENQaC>; Tue, 14 May 2002 12:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315820AbSENQaA>; Tue, 14 May 2002 12:30:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315819AbSENQ3c>; Tue, 14 May 2002 12:29:32 -0400
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Tue, 14 May 2002 17:48:29 +0100 (BST)
Cc: jes@wildopensource.com ('Jes Sorensen'),
        Steve@ChyGwyn.com ('Steve Whitehouse'), linux-kernel@vger.kernel.org
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A52@srgraham.eng.emc.com> from "chen, xiangping" at May 14, 2002 12:07:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177fTR-0008I7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Xiangping> So for gigabit Ethernet driver, what is the optimal mem
> Xiangping> configuration for performance and reliability?
> 
> It depends on your application, number of streams, general usage of
> the connection etc. There's no perfect-for-all magic number.

The primary constraints are

	TCP max window size
	TCP congestion window size (cwnd)
	Latency

Most of the good discussion on this matter can be found in the ietf
archives from the window scaling options work, and in part in the RFC's
that led to

