Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbRAKAQJ>; Wed, 10 Jan 2001 19:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbRAKAP7>; Wed, 10 Jan 2001 19:15:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130150AbRAKAPz>; Wed, 10 Jan 2001 19:15:55 -0500
Subject: Re: Problem with module versioning in 2.4.0
To: jeremyhu@uclink4.berkeley.edu (Jeremy Huddleston)
Date: Thu, 11 Jan 2001 00:17:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A5CEF9B.1E36A6D1@uclink4.berkeley.edu> from "Jeremy Huddleston" at Jan 10, 2001 03:26:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GVR1-0001J9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See below for my origional problem.  It seems the problem lies in the
> module versioning option.

Not quite

> When the system boots, I am spammed with the following line:
> insmod: /lib/modules/2.4.0/kernel/net/unix/unix.o: insmod net-pf-1
> failed

What happens is this

kernel needs unix sockets
kernel invokes modprobe
modprobe opens a unix socket
	kernel needs unix sockets
	kernel invokes modprobe
		.....

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
