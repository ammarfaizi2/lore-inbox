Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUBZUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbUBZUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:31:59 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:31378 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262977AbUBZUbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:31:49 -0500
Date: Thu, 26 Feb 2004 18:18:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58L.0402261746280.8840@logos.cnet>
Message-ID: <Pine.LNX.4.58L.0402261814030.8840@logos.cnet>
References: <Pine.LNX.4.58L.0402261746280.8840@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: Re: [PATCH] cyclades async driver update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Marcelo Tosatti wrote:

>
> Hi,
>
> The following patch is the first of several planned fixes for the cyclades
> multiserial cards driver.
>
> Its mostly a sync with in-house driver:
>
> - Prevent users from opening non-existing Z ports
> - Implement special XON/XOFF character handling in Z cards
> - Prevent data-loss on Z cards
> - Throttling fix for Z card
> - Only throttle if CTS/RTS are set
> - Fix accounting of received data
>
> Kudos to Cyclades R&D
>
> Please apply.

Patch adds unused variables, please apply this on top (my bad):

--- linux-2.6.3/include/linux/cyclades.h.orig	2004-02-26 17:14:30.000000000 -0300
+++ linux-2.6.3/include/linux/cyclades.h	2004-02-26 17:12:53.000000000 -0300
@@ -111,8 +111,6 @@
 #define CYGETCARDINFO		0x435911
 #define	CYSETWAIT		0x435912
 #define	CYGETWAIT		0x435913
-#define CYSETHIGHWATERMARK      0x435914
-#define CYGETHIGHWATERMARK      0x435915


 /*************** CYCLOM-Z ADDITIONS ***************/
