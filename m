Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTFDIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 04:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTFDIWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 04:22:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3305 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263169AbTFDIWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 04:22:24 -0400
Date: Tue, 3 Jun 2003 21:40:50 +1000
To: davem@redhat.com
Cc: linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: esp name conflict with drivers/char/esp.c
Message-ID: <20030603114050.GA32065@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I was trying to get the native IPsec stack working under 2.4.  It almost
worked except that NEWSA was coming back with ENOENT.   It turned out
that the esp module that I loaded was trying to register character
devices :) It didn't bite me under 2.5 as drivers/char/esp.c didn't
compile.

So one of them's got to be renamed.  Do you have a preference as to
which way to go?

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
