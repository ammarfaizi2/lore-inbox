Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265781AbUF2P1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265781AbUF2P1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUF2P1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:27:40 -0400
Received: from legaleagle.de ([217.160.128.82]:36577 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S265781AbUF2P1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:27:37 -0400
Message-ID: <40E18A8A.4060500@trash.net>
Date: Tue, 29 Jun 2004 17:28:10 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
Cc: coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] undefined reference to `ip_conntrack_untracked'
References: <20040629140234.GT13365@wiggy.net>
In-Reply-To: <20040629140234.GT13365@wiggy.net>
Content-Type: multipart/mixed;
 boundary="------------090303020108090404090207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303020108090404090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please try this patch.

Wichert Akkerman wrote:

>(Not mailing this to netfilter-devel since it helpfully blocks posts
>from non-subscribers)
>  
>

Helpfully to subscribers ;)

Regards
Patrick

>WHen trying to compile a 2.6.7 kernel I got the following:
>
>net/built-in.o(.text+0x59781): In function `target':
>: undefined reference to `ip_conntrack_untracked'
>make: *** [.tmp_vmlinux1] Error 1
>
>.config is below.
>
>Wichert.
>  
>


--------------090303020108090404090207
Content-Type: text/plain;
 name="X"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="X"

===== net/ipv4/netfilter/Kconfig 1.20 vs edited =====
--- 1.20/net/ipv4/netfilter/Kconfig	2004-03-30 06:24:39 +02:00
+++ edited/net/ipv4/netfilter/Kconfig	2004-06-29 17:25:55 +02:00
@@ -582,6 +582,7 @@
 config IP_NF_TARGET_NOTRACK
 	tristate  'NOTRACK target support'
 	depends on IP_NF_RAW
+	depends on IP_NF_CONNTRACK
 	help
 	  The NOTRACK target allows a select rule to specify
 	  which packets *not* to enter the conntrack/NAT

--------------090303020108090404090207--
