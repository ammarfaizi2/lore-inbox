Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130679AbQLOMt5>; Fri, 15 Dec 2000 07:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOMtr>; Fri, 15 Dec 2000 07:49:47 -0500
Received: from r2-pc.dcs.qmw.ac.uk ([138.37.88.145]:50560 "EHLO r2-pc")
	by vger.kernel.org with ESMTP id <S130679AbQLOMtf>;
	Fri, 15 Dec 2000 07:49:35 -0500
Date: Fri, 15 Dec 2000 12:19:04 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: BOOTP not working in 2.2.18?
Message-ID: <Pine.LNX.4.30.0012151216020.895-100000@r2-pc>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the file net/ipv4/ipconfig.c is a variable called ic_enabled which is
initialised to zero and never set anywhere. a check is made and bootp
isn't run if its not set. Setting it to 1 before the check makes it appear
to work.

[ The user-space bootpc doesn't want to play ball at all these days.. :-( ]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
