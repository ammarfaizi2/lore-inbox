Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSGYV3d>; Thu, 25 Jul 2002 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSGYV3d>; Thu, 25 Jul 2002 17:29:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15090 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316512AbSGYV3d>; Thu, 25 Jul 2002 17:29:33 -0400
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020725110033.G2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 23:46:23 +0100
Message-Id: <1027637183.11604.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 18:00, Cort Dougan wrote:
> This is from the -atp (Aunt Tillie and Penelope) tree.
> 
> This patch adds a small function that looks up symbol names that correspond
> to given addresses by digging through the already existent ksyms table.
> It's invaluable for debugging on embedded systems - especially when testing
> modules - since ksymoops is a hassle to deal with in cross-build
> environments.  We already have this info in the kernel so we might as well
> use it.

I would much rather have hex data. It makes all the parsing tools
connected to the serial port that much easier. If instead of hacking the
kernel you bang out a little bit of expect you can do it all on the host
driving the embedded box, and find the file names, and open them in an
editor at the right function, and do a parallel lookup in bugzilla for
matching oops logs...


