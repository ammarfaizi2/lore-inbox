Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQLZBaB>; Mon, 25 Dec 2000 20:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbQLZB3v>; Mon, 25 Dec 2000 20:29:51 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:60663 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130667AbQLZB3c>; Mon, 25 Dec 2000 20:29:32 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Cesar Eduardo Barros" <cesarb@nitnet.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: TCP keepalive seems to send to only one port
Date: Mon, 25 Dec 2000 16:59:05 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEDNMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <20001225224654.A2080@flower.cesarb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cesar Barros wrote:

> On Mon, Dec 25, 2000 at 04:33:07PM -0800, David Schwartz wrote:
> > 	If the administrator of the NAT meant for you to have a
> > permanent mapping,
> > she would have put one there. Using keepalives to hold a NAT entry open
> > indefinitely without activity would be considered abuse in most NAT
> > configurations. The NAT might not consider a keepalive to be
> > activity anyway
> > (arguably, it shouldn't).

> Well, consider the scenario of an application which opens a
> control connection
> and a data connection, and the data connection remains idle for some hours
> while you get to the beginning of the queue, and then the
> transfer starts. The
> data connection is not open forever, and the timeout (and the
> periodic pings)
> is on the control connection.

	I would consider that application broken. The data connection should be
opened when it's needed, not left idle for hours and used later. If the data
connection does break somehow, there should be a provision for
re-establishing it without losing all application-level state.

	I'm not saying it shouldn't be possible to work around a defective
application protocol. But to expect there to be some easy way to just flip a
switch and fix it is unreasonable.

	The NAT may not even consider a keepalive to be activity. There's no
logical reason it should if the timeout is less than many hours.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
