Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSENRhA>; Tue, 14 May 2002 13:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315920AbSENRg7>; Tue, 14 May 2002 13:36:59 -0400
Received: from [168.159.40.71] ([168.159.40.71]:33032 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S315919AbSENRg6>; Tue, 14 May 2002 13:36:58 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A54@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: jes@wildopensource.com, Steve@ChyGwyn.com, linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Tue, 14 May 2002 13:36:49 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But ... It seems that there is no direct way to adjust the tcp max 
window size in Linux kernel.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, May 14, 2002 12:48 PM
To: chen, xiangping
Cc: jes@wildopensource.com; Steve@ChyGwyn.com;
linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


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
