Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSFEPED>; Wed, 5 Jun 2002 11:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFEPEC>; Wed, 5 Jun 2002 11:04:02 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:30729 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S315449AbSFEPEB>; Wed, 5 Jun 2002 11:04:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Conflicting symbols of zlib (jffs2 and ppp_deflate)
Date: Wed, 5 Jun 2002 12:07:01 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02060512070101.28263@henrique.cyclades.com.br>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!

I've found out something that probably is a bug. I've tried to compile a 
kernel using the generic ppp (and the ppp_deflate module) and the jffs2 file 
system. 

No problems at the compilation but when the linker started off it complained 
about conflicting symbols in net.o and fs.o objects.

Taking a more carefully look at the problem I discovered that the files 
zlib.c and zlib.h are in two differents places in the kernel (fs/jffs2/ and 
drivers/net/) and the diff of the files don't show any significant difference.

As a workaround for this problem I removed the zlib.o from fs/jffs2/Makefile 
but it wouldn't work if I wasn't using the ppp stuff.

I'd like to know if anyone (ppp and jffs2 guys) have a solution for this 
problem or at least a suggestion. Any comment will be very welcomed.

thanks
henrique
