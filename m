Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135319AbRALX5y>; Fri, 12 Jan 2001 18:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRALX5o>; Fri, 12 Jan 2001 18:57:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135319AbRALX5b>; Fri, 12 Jan 2001 18:57:31 -0500
Subject: Re: 2.4.0 bug - X doesn't start
To: florin@sgi.com (Florin Andrei)
Date: Fri, 12 Jan 2001 23:59:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A5F86FC.86FA69FB@sgi.com> from "Florin Andrei" at Jan 12, 2001 02:36:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HE6K-0005Ho-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	When i boot the system, X Window doesn't start automatically (but if i boot a
> 2.2 kernel, it does). This is very strange.
> 	Also, seems like Sendmail waits forever until it starts. But this might be a
> network card driver problem (not sure, though).

Its the behaviour changes in 2.4 with regard to UDP error messages. Glibc doesnt
yet have the code to adapt.

However: It does imply your resolv.conf may reference a server that doesnt
exist or is unreachable. Unfortunately if your server is across a dialup
or other link brought up after boot then 2.4 + glibc isnt going to be happy
until that work is completed and you get a newer glibc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
