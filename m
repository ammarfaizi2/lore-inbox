Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbTA0OSV>; Mon, 27 Jan 2003 09:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTA0OSV>; Mon, 27 Jan 2003 09:18:21 -0500
Received: from taz.cerebus.com ([208.254.26.145]:19673 "EHLO taz.cerebus.com")
	by vger.kernel.org with ESMTP id <S267179AbTA0OSU>;
	Mon, 27 Jan 2003 09:18:20 -0500
Date: Mon, 27 Jan 2003 09:27:25 -0500 (EST)
From: David C Niemi <lkernel2003@tuxers.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
In-Reply-To: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
Message-ID: <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, David S. Miller wrote:
> What happens if you comment out the enabling of
> NETIF_F_TSO in drivers/net/e1000/e1000_main.c around
> line 428? Does the problem persist? 

Yes, the problem persists.

Interesting that it seems to happen on a variety of Ethernet cards, I
wonder if the problem's in the TCP area.  Interestingly it seems like on
the *unafflicted* systems I can still see the "delayed character" symptom,
but eventually the outstanding characters do get echoed back to the
screen.  Whereas on the afflicted 2.5.5x systems, as soon as there is a
delay (perhaps due to a retransmission) all outstanding characters (after 
the delayed one) are lost or permanently hung up somewhere.

DCN

