Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbULVM5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbULVM5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbULVM5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:57:52 -0500
Received: from [62.206.217.67] ([62.206.217.67]:29897 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261982AbULVM5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:57:48 -0500
Message-ID: <41C96F24.2050409@trash.net>
Date: Wed, 22 Dec 2004 13:57:08 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Sami Farin <7atbggg02@sneakemail.com>, linux-kernel@vger.kernel.org,
       solt2@dns.toxicfilms.tv
Subject: Re: what/where is ss tool ?
References: <00be01c4e819$aca09cd0$0e25fe0a@pysiak> <41C95B88.1070409@trash.net> <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak> <20041222122758.GB6627@m.safari.iki.fi>
In-Reply-To: <20041222122758.GB6627@m.safari.iki.fi>
Content-Type: multipart/mixed;
 boundary="------------080605030604000507030308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080605030604000507030308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave,

please apply this patch which gives users a pointer where
to find the ss tool and adds an explanation about TCPDIAG
and IPV6.

Regards
Patrick

Signed-off-by: Patrick McHardy <kaber@trash.net>

Sami Farin wrote:
> On Wed, Dec 22, 2004 at 01:15:14PM +0100, Maciej Soltysiak wrote:
> 
>>Thanks Patrick!
>>
>>Maybe we could add a line to the help so people, like me, that were
>>not aware that ss exists.
>>AFAICS ss appeared not so long ago, I think many distributions are
>>still using versions that do not have ss.
>>Or I may be wrong.
>>
>>Regards,
>>Maciej
>>diff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig
>>--- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100
>>+++ linux/net/ipv4/Kconfig	2004-12-22 13:00:36.000000000 +0100
>>@@ -355,7 +355,8 @@
>>	default y
>>	---help---
>>	  Support for TCP socket monitoring interface used by native Linux
>>-	  tools such as ss.
>>+	  tools such as ss. ss comes from iproute2.
>>+	  http://developer.osdl.org/dev/iproute2/
> 
> 
> Add also "if you wish to view IPv6 addresses (Local/Peer Address) with ss,
> IPv6 support must be built into the kernel (not as a module)."
> 
> 
>>	  If unsure, say Y.
> 
> 


--------------080605030604000507030308
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

===== net/ipv4/Kconfig 1.23 vs edited =====
--- 1.23/net/ipv4/Kconfig	2004-11-03 21:20:02 +01:00
+++ edited/net/ipv4/Kconfig	2004-12-22 13:52:14 +01:00
@@ -355,7 +355,10 @@
 	default y
 	---help---
 	  Support for TCP socket monitoring interface used by native Linux
-	  tools such as ss.
+	  tools such as ss. ss is included in iproute2, currently downloadable
+	  at http://developer.osdl.org/dev/iproute2/. If you want IPv6 support
+	  and have selected IPv6 as a module, you need to built this as a
+	  module too.
 	  
 	  If unsure, say Y.
 

--------------080605030604000507030308--
