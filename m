Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272309AbRH3QUN>; Thu, 30 Aug 2001 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272312AbRH3QUD>; Thu, 30 Aug 2001 12:20:03 -0400
Received: from pD903CA2F.dip.t-dialin.net ([217.3.202.47]:23228 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S272309AbRH3QT6>; Thu, 30 Aug 2001 12:19:58 -0400
Date: Thu, 30 Aug 2001 18:18:56 +0200
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac4
Message-ID: <20010830181856.A6691@no-maam.dyndns.org>
In-Reply-To: <20010830154637.A4570@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830154637.A4570@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.20i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 03:46:37PM +0100, Alan Cox wrote:
> 2.4.9-ac4
> o	Fix X.75 with new hisax drivers and an isdn	(Kai Germaschewski)
> 	disconnect race

What is that exactly? I got the problem that mppp is not working
correctly with 2.4.9 and 2.4.10-pre2 (and I tried some 2.4.9-ac too).
When I came to my router, I had the following lines on my console

isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_xmit: lp->ppp_slot -1

And after these lines I had a kernel-oops on my console. After running
ksymoops I found out, that the kernel was doing something in the
sceduler (if I understand the output of ksymoops right). But these
crashes must be mppp-related, because if I never execute isdnctrl
addlink ippp0 the system never crashes and these error-messages never
appear.
