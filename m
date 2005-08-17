Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVHQDXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVHQDXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVHQDXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:23:12 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:9854 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1750813AbVHQDXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:23:11 -0400
Message-ID: <4302AD95.20704@cosmosbay.com>
Date: Wed, 17 Aug 2005 05:23:01 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@vger.kernel.org, lartc@mailman.ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] iproute2 util update
References: <20050816143416.61c10513@dxpl.pdx.osdl.net>
In-Reply-To: <20050816143416.61c10513@dxpl.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------040102030005070604000809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102030005070604000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Stephen Hemminger a écrit :
> http://developer.osdl.org/dev/iproute2/download/iproute2-050816.tar.gz
> 
> Update to iproute2 to include:
> 	* Limit ip neigh flush to 10 rounds
> 	* tc ematch support (thomas)
> 	* build cleanups (thomas, et al)
> 	* Fix for options process with ipt (jamal)
> 	* Fix array overflow in paretonormal distribution build
> 	* Update include files to 2.6.13
> 	* Decnet doc update (Steven Whithouse)
> 
> Note: the ematch support won't build on really old versions of bison (1.28),
>       but the kernel on those systems wouldn't support it anyway.
> -
Thank you

Could you please apply this patch.

	* Fix lnstat : First column should not be summed

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------040102030005070604000809
Content-Type: text/plain;
 name="lnstat_util.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lnstat_util.diff"

--- iproute2-050816-orig/misc/lnstat_util.c	2005-03-18 20:40:19.000000000 +0100
+++ iproute2-050816/misc/lnstat_util.c	2005-08-17 05:21:04.000000000 +0200
@@ -55,7 +55,7 @@
 		for (j = 0; j < lf->num_fields; j++) {
 			unsigned long f = strtoul(ptr, &ptr, 16);
 			if (j == 0) 
-				lf->fields[j].values[i] += f;
+				lf->fields[j].values[i] = f;
 			else
 				lf->fields[j].values[i] += f;
 		}

--------------040102030005070604000809--
