Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRHWUYu>; Thu, 23 Aug 2001 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270271AbRHWUYl>; Thu, 23 Aug 2001 16:24:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268996AbRHWUYd>; Thu, 23 Aug 2001 16:24:33 -0400
Subject: Re: macro conflict
To: mag@fbab.net ("Magnus Naeslund\(f\)")
Date: Thu, 23 Aug 2001 21:27:35 +0100 (BST)
Cc: raybry@timesn.com, twalberg@mindspring.com (Tim Walberg),
        linux-kernel@vger.kernel.org
In-Reply-To: <03fc01c12c10$8155b060$020a0a0a@totalmef> from "Magnus Naeslund\(f\)" at Aug 23, 2001 10:16:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a14h-0004YY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But then again, how do you know it's the type of x we want, maybe we want
> type of y, that is and signed char (not an int like x).
> Talk about hidden buffer overflow stuff :)

This is one of the big problems with min and max, you get deeply suprising
and unpleasant results if you don't consider sign propogation, sizes and
overruns carefully. In C there are some great evils in that area, and its
one reason a lot of people prefer to write such code explicitly.

Alan
