Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbQLZBDz>; Mon, 25 Dec 2000 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQLZBDp>; Mon, 25 Dec 2000 20:03:45 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:30455 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131096AbQLZBDe>; Mon, 25 Dec 2000 20:03:34 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Cesar Eduardo Barros" <cesarb@nitnet.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP keepalive seems to send to only one port
Date: Mon, 25 Dec 2000 16:33:07 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKOEDJMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <20001223223814.A2281@flower.cesarb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, Dec 23, 2000 at 04:19:31PM -0800, David Schwartz wrote:

> > > This means that keepalive is useless for keeping alive more than
> > > one connection
> > > to a given host.

> > 	Actually, keepalive is useless for keeping connections
> > alive anyway. It's
> > very badly named. It's purpose is to detect dead peers, not keep peers
> > alive.
>
> Then what do you do when you are behind a NAT?

	If the administrator of the NAT meant for you to have a permanent mapping,
she would have put one there. Using keepalives to hold a NAT entry open
indefinitely without activity would be considered abuse in most NAT
configurations. The NAT might not consider a keepalive to be activity anyway
(arguably, it shouldn't).

> And how do you
> expire entries in
> ESTABLISHED state that could stay lingering forever without some sort of
> keepalive? (The FINs might have been lost due to a conectivity
> transient, so
> you can have another perfectly valid and alive connection with
> the same host,
> and application-level timeouts are useless for some applications
> (*cough*nc*cough*))

	I don't understand this argument. First you demonstrate the need for
application-level timeouts, then you say application-level timeouts are
useless. Actually, your first argument is correct, protocols layered on top
of TCP that don't provide for timeouts are defective.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
