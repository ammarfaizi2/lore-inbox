Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281684AbRKQCXZ>; Fri, 16 Nov 2001 21:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281685AbRKQCXQ>; Fri, 16 Nov 2001 21:23:16 -0500
Received: from CPE-61-9-148-175.vic.bigpond.net.au ([61.9.148.175]:40943 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S281684AbRKQCXF>; Fri, 16 Nov 2001 21:23:05 -0500
Message-ID: <3BF5C9DA.DA060A38@eyal.emu.id.au>
Date: Sat, 17 Nov 2001 13:22:18 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: It's me again ...
In-Reply-To: <20011117015851.531B415B4A@kubrick.trljc.com>
Content-Type: multipart/mixed;
 boundary="------------CFD801D177A11D641B288A20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CFD801D177A11D641B288A20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tony Reed wrote:
> 
> I've been building kernels since 2.2.15 or something, and I've never
> had problems before, so bear with me.
> 
> Where is "deacivate_page" defined?  Because, right at the end, I'm
> getting:

Read the list, there is a well known patch.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------CFD801D177A11D641B288A20
Content-Type: text/plain; charset=us-ascii;
 name="2.4.14-loop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.14-loop.patch"

--- linux-2.4.14/drivers/block/loop.c	Thu Oct 25 13:58:34 2001
+++ linux-2.4.14-loop/drivers/block/loop.c	Mon Nov  5 17:06:08 2001
@@ -207,7 +207,6 @@
 		index++;
 		pos += size;
 		UnlockPage(page);
-		deactivate_page(page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -218,7 +217,6 @@
 	kunmap(page);
 unlock:
 	UnlockPage(page);
-	deactivate_page(page);
 	page_cache_release(page);
 fail:
 	return -1;

--------------CFD801D177A11D641B288A20--

