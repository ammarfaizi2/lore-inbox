Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269633AbRHHXYy>; Wed, 8 Aug 2001 19:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRHHXYp>; Wed, 8 Aug 2001 19:24:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:32779 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269633AbRHHXYh>;
	Wed, 8 Aug 2001 19:24:37 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Duplicate symbols in -ac JFFS2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Aug 2001 09:24:41 +1000
Message-ID: <6361.997313081@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.7-ac9, if both ppp deflate and JFFS2 are built into the kernel,
there are lots of duplicate symbols.

drivers/net/ppp_deflate.o(.data+0x0): multiple definition of `deflate_copyright'
fs/jffs2/jffs2.o(.data+0x20): first defined here
drivers/net/ppp_deflate.o: In function `deflateInit_':
drivers/net/ppp_deflate.o(.text+0x0): multiple definition of `deflateInit_'
...

What happened to the idea of puttting the deflate code in its own
object with exported symbols, instead of duplicating it in each
directory?

