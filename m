Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTFRRFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFRRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:05:29 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:58377 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S265406AbTFRRDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:03:17 -0400
Date: Wed, 18 Jun 2003 19:17:11 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <P@draigBrady.com>
Cc: <linux-kernel@vger.kernel.org>, <debian-glibc@lists.debian.org>
Subject: Re: VIA Ezra CentaurHauls
In-Reply-To: <3EF07A43.8000505@draigBrady.com>
Message-ID: <Pine.LNX.4.33.0306181908190.2967-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> find / -perm +111 -type f |
> while read bin; do
>      objdump --disassemble $bin 2>/dev/null |
>      grep -q cmov && echo "$bin has cmov"
> done

So, using the above for libraries I found 3 libraries on the system, that
use cmov:

libldap.so.2.0.15
libcrypto.so.0.9.6
libqt-mt.so.3.0.5

So, the libraries have nothing to do with the kernel, the Debian guys
might take a notice of them (not glibc, but still...). But what I do find
interesting and noteworthy - is that this problem is specific only to some
revisions of this CPU, which might be of interest to all.

Thanks for the tip with the script!
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

