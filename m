Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTJPVDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJPVDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:03:22 -0400
Received: from [193.138.115.2] ([193.138.115.2]:39175 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263082AbTJPVDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:03:19 -0400
Date: Thu, 16 Oct 2003 23:01:37 +0200 (CEST)
From: Jesper Juhl <juhl@dif.dk>
To: sting sting <zstingx@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: short explanation -jiffies (newbie)
In-Reply-To: <Sea2-F17IdRclmEBOum000104f7@hotmail.com>
Message-ID: <Pine.LNX.4.56.0310162244380.3186@jju_lnx.backbone.dif.dk>
References: <Sea2-F17IdRclmEBOum000104f7@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Oct 2003, sting sting wrote:

> Hello,
> can someone give a short explanation what jiffies are?

A short explanation :

"Basic packet of kernel time, around 10ms on x86. Related to HZ, the basic
resolution of the operating system. The timer interrupt is raised each
10ms, which then performs some h/w timer related stuff, and marks a couple
of bh's ready to run if applicable."

is given at :

http://www.kernelnewbies.org/glossary/#J

For more details you could take a look at these files (there are more) in
the kernel source :

include/linux/delay.h
init/main.c

to find more relevant files try something like this in the kernel source
tree :

for i in `find -name *.[ch]`; do grep -H jiffy $i; done



Kind regards,

Jesper Juhl
