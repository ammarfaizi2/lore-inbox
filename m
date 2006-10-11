Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1161183AbWJKTlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWJKTlA (ORCPT <rfc822;akpm@zip.com.au>);
	Wed, 11 Oct 2006 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWJKTlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:41:00 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:9447 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161182AbWJKTk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:40:58 -0400
Subject: funny looking equation
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:40:55 -0400
Message-Id: <1160595655.5512.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just testing some of my parsing code on all the .c and .h files in
the Linux kernel, and I came up with this little equation:

from 2.6.18 drivers/atm/eni.c:1272


---
                        int div;

                        if (!*pcr) *pcr = eni_dev->tx_bw+reserved;
                        for (*pre = 3; *pre >= 0; (*pre)--)
                                if (TS_CLOCK/pre_div[*pre]/64 > -*pcr) break;
                        if (*pre < 3) (*pre)++; /* else fail later */
                        div = pre_div[*pre]*-*pcr;
                                    ^^^^^^^^^^^^^
    This could really do with some spaces and a couple of parenthesis.

                        DPRINTK("max div %d\n",div);
                        *res = (TS_CLOCK+div-1)/div-1;
---


Oh well, this isn't a bug.  Just something that someone might want to
clean up the next time they touch that code.

-- Steve


