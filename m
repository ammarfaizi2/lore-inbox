Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVAEKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVAEKfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVAEKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:35:34 -0500
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:39301 "EHLO
	av8-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262285AbVAEKfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:35:17 -0500
Message-ID: <41DBC2E3.8090908@gaisler.com>
Date: Wed, 05 Jan 2005 11:35:15 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [5/7] LEON SPARC V8 processor support for linux-2.6.10
References: <41DAE8BB.7050501@gaisler.com> <20050104191105.GN2708@holomorphy.com>
In-Reply-To: <20050104191105.GN2708@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------040207030109090804080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040207030109090804080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, the patch was accidentally reversed. I have attached the
correct diff2.6.10_arch_sparc_Kocnfig.diff.

Jiri.



William Lee Irwin III wrote:
> On Tue, Jan 04, 2005 at 08:04:27PM +0100, Jiri Gaisler wrote:
> 
>>Leon3 serial+ethermac driver:
>>[5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig
>>--- ../linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-03 18:03:49.000000000 +0100
>>+++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 18:01:44.000000000 +0100
>>@@ -239,12 +239,6 @@
>> 	  Say Y here if you are running on a Leon3 from grlib
>> 	  (download from www.gaisler.com). 
>> 
>>-if LEON_3
>>-
>>-source "drivers/amba/Kconfig"
>>-
>>-endif
>>-
>> endif
> 
> 
> This one is a bit unusual. It doesn't seem to have been added by a
> previous patch. The intended effect may have been something else. Were
> there supposed to be drivers in this patch?
> 
> 
> -- wli
> 
> .
> 

-- 
--------------------------------------------------------------------------
Gaisler Research, 1:a Långgatan 19, 413 27 Goteborg, Sweden, +46-317758650
fax: +46-31421407 email: info@gaisler.com, home page: www.gaisler.com
--------------------------------------------------------------------------



--------------040207030109090804080505
Content-Type: text/plain;
 name="diff2.6.10_arch_sparc_Kconfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_arch_sparc_Kconfig.diff"

diff -Naur linux-2.6.10-driver/arch/sparc/Kconfig linux-2.6.10-driver-patch/arch/sparc/Kconfig
--- linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-05 11:24:36.000000000 +0100
+++ linux-2.6.10-driver-patch/arch/sparc/Kconfig	2005-01-05 11:27:52.000000000 +0100
@@ -241,6 +241,11 @@
 
 endif
 
+if LEON_3
+
+source "drivers/amba/Kconfig"
+
+endif
           
 if !SUN4
 

--------------040207030109090804080505--
