Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271332AbRIAT4x>; Sat, 1 Sep 2001 15:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIAT4n>; Sat, 1 Sep 2001 15:56:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271332AbRIAT4f>; Sat, 1 Sep 2001 15:56:35 -0400
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Sat, 1 Sep 2001 20:59:13 +0100 (BST)
Cc: davem@redhat.com (David S . Miller), ak@muc.de (Andi Kleen),
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov), linux-kernel@vger.kernel.org
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch> from "Jamie Lokier" at Sep 01, 2001 06:17:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dGvB-0005Un-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Packets arrive _very_ slowly -- about 1 packet every 5.2 seconds.
> (Showing that "9600 baud" is even worse false advertising than "56k").

With my 7110 I get close to 8000bps throughput . To get that I ended up
having to fix various flow control setting so the tiny buffers on the 
phone didnt keep overflowing

> The interesting thing is that there isn't any evidence of packet loss.

The modem/phone link does its own retransmit and recovery sequences. That
means that on a very flaky link you _will_ see long pauses with retransmits
at link layer going on

