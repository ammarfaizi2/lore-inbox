Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbRFOUfu>; Fri, 15 Jun 2001 16:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbRFOUfa>; Fri, 15 Jun 2001 16:35:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1288 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264521AbRFOUfV>; Fri, 15 Jun 2001 16:35:21 -0400
Subject: Re: drivers/usb/ov511.c does not compile
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Fri, 15 Jun 2001 21:34:21 +0100 (BST)
Cc: runesong@earthlink.net (Kelledin Tane), linux-kernel@vger.kernel.org
In-Reply-To: <20010615160518.A30332@sventech.com> from "Johannes Erdfelt" at Jun 15, 2001 04:05:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15B0IP-00073f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the developer's blessing on this, and also nice to know exactly what
> > version number to give this driver in 2.4.5 stock.
> 
> This has already been fixed in the 2.4.5 pre patches.

.6 I assume.

ov511 still has some bad bugs in it - it doesnt work with some uhci drivers
and it also does precisely the wrong thing when you set the capture size and
breaks stuff like ffserver. The comments are right but the code picks the
size which is bigger than the capture, not the nearest smaller size..

