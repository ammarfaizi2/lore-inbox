Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbREZXDS>; Sat, 26 May 2001 19:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbREZXB1>; Sat, 26 May 2001 19:01:27 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262656AbREZXAg>;
	Sat, 26 May 2001 19:00:36 -0400
Date: Sat, 26 May 2001 13:45:25 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: David G?mez <davidge@jazzfree.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ov511 driver doesn't compile
Message-ID: <20010526134525.V15193@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0105261250100.8159-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105261250100.8159-100000@fargo>; from davidge@jazzfree.com on Sat, May 26, 2001 at 12:52:48PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 12:52:48PM +0200, David G?mez  wrote:
> On kernel 2.4.5, the ov511 usb driver shows a failure at compile
> time. const version is not defined.

I send a patch to Linus for linux-2.4.5-pre5, but apparently he didn't
include it. Here it is again.

BTW, this is already fixed in 2.4.4-ac17, so I suppose Alan will pass
it to Linus.


Erik

--- drivers/usb/ov511.c.orig	Thu May 24 15:21:58 2001
+++ drivers/usb/ov511.c	Thu May 24 15:24:20 2001
@@ -337,7 +337,7 @@
 	/* IMPORTANT: This output MUST be kept under PAGE_SIZE
 	 *            or we need to get more sophisticated. */
 
-	out += sprintf (out, "driver_version  : %s\n", version);
+	out += sprintf (out, "driver_version  : %s\n", DRIVER_VERSION);
 	out += sprintf (out, "custom_id       : %d\n", ov511->customid);
 	out += sprintf (out, "model           : %s\n", ov511->desc ?
 		clist[ov511->desc].description : "unknown");


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
