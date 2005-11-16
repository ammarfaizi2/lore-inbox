Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVKPPKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVKPPKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVKPPKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:10:10 -0500
Received: from mail.linicks.net ([217.204.244.146]:32691 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030365AbVKPPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:10:08 -0500
From: Nick Warne <nick@linicks.net>
To: kaos@ocs.com.au
Subject: 2.4.31 make - path name breakage (perhaps)
Date: Wed, 16 Nov 2005 15:09:04 +0000
User-Agent: KMail/1.8.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161509.04855.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

I googled a bit on this, but the nature of the bug makes it impossible to 
search properly.

I found this out as I was trying to build Netgear router DG834 firmware from 
GPL source, and make dep fails.

The reason is due to the untarred path name that includes () I found.

I tested on virgin kernel 2.4.31 with GNU Make version 3.79.1.

top level directory of kernel source as a test:

linux-2.4.31(test)/

And the errors (with a lot removed) - it does a little first then:

> make mrproper
/bin/sh: -c: line 1: syntax error near unexpected token 
`/home/nick/kernel/linux-2.4.31(t'
...
...
make: *** [mrproper] Error 2

> make dep
/bin/sh: -c: line 1: syntax error near unexpected token 
`/home/nick/kernel/linux-2.4.31(test)'
...
...
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/home/nick/kernel/linux-2.4.31(test)/kernel'
make[1]: *** [_sfdep_kernel] Error 2
make[1]: Leaving directory `/home/nick/kernel/linux-2.4.31(test)'
make: *** [dep-files] Error 2



I haven't a clue if this is a 'make' issue or not, but a few tests on other 
source builds ok.

Nick
-- 
http://sourceforge.net/projects/quake2plus/

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

