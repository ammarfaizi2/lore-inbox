Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbRCSSxk>; Mon, 19 Mar 2001 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131586AbRCSSxb>; Mon, 19 Mar 2001 13:53:31 -0500
Received: from chaos.ao.net ([205.244.242.21]:10757 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S131581AbRCSSxV>;
	Mon, 19 Mar 2001 13:53:21 -0500
Message-Id: <200103191852.f2JIqZn03675@burned.furry.ao.net>
To: linux-kernel@vger.kernel.org
Subject: AMI MegaRAID support in 2.4.3-pre4
Date: Mon, 19 Mar 2001 13:52:35 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc: me any response, I only keep up with linux-kernel via the archives)

I see pre4 has an updated megaraid.c...  It Just Don't Work(tm)

I thought it might be a part of Alan's merges, but it's not
in the -ac tree.  Linus, who sent you this patch?

Recognizes the controller, accesses my two logical volumes,
cp /dev/sda /dev/null causes the drives to light up....
but the data being copied looks to be random bits of memory.
I see syslog in there and lilo messages... all sorts of things
that don't belong.  It appears to be claiming pages used by /dev/hda,
or something silly.  I even see my IDE MBR, and fdisk recognizes the 
SCSI disc as being partitoned the same as /dev/hda.

AMI MegaRAID express 500, trying 2.4.2, 2.4.3-pre4.

Apparently the chip is too new for driver version 1.07b, (not recognized
at all by the kernel) and 1.14g has the problems I'm going over here.

I also tried I2O, but it didn't recognize the card either.


