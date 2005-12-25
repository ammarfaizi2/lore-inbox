Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVLYUID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVLYUID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVLYUID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:08:03 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:1319 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbVLYUIB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:08:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ma6WEQ0IXO3PbZOkvet3fmNw4URqHAWpCAsynF0feSlKOzHE/nLmRc32bITlvRielF2PfMcJcECnv8XB0X4xUdIzjZWv5BKOurJucCvuMYZlkPdGoWzs9+7PRYwCvQxZevf5yGwRsffvsICdv4LRr41YBF0ahdJBHLCp/3OzSwk=
Message-ID: <aa4c40ff0512251208j46e5de99o51e8d18f5542e9a2@mail.gmail.com>
Date: Sun, 25 Dec 2005 12:08:00 -0800
From: James Lamanna <jlamanna@gmail.com>
To: kees@outflux.net
Subject: Re: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:

> Eliminates compile-time warnings from "r" being uninitialized.
>

What version of gcc are you using?

I get no warnings on 3.4.4:
  CC [M]  lib/zlib_inflate/infblock.o
  CC [M]  lib/zlib_inflate/infcodes.o
  CC [M]  lib/zlib_inflate/inffast.o
  CC [M]  lib/zlib_inflate/inflate.o
  CC [M]  lib/zlib_inflate/inflate_sync.o
  CC [M]  lib/zlib_inflate/inftrees.o
  CC [M]  lib/zlib_inflate/infutil.o
  CC [M]  lib/zlib_inflate/inflate_syms.o
  LD [M]  lib/zlib_inflate/zlib_inflate.o
  Building modules, stage 2.
  MODPOST
  CC      lib/zlib_inflate/zlib_inflate.mod.o
  LD [M]  lib/zlib_inflate/zlib_inflate.ko

agard linux-2.6.15-rc7 # gcc --version
gcc (GCC) 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)

Looks like a gcc bug that was fixed?
