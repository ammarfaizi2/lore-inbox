Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbREYGVa>; Fri, 25 May 2001 02:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263575AbREYGVK>; Fri, 25 May 2001 02:21:10 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:45831 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263574AbREYGVF>;
	Fri, 25 May 2001 02:21:05 -0400
Date: Thu, 24 May 2001 22:19:39 -0700
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <jerdfelt@valinux.com>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
Message-ID: <20010524221939.D8162@kroah.com>
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Thu, May 24, 2001 at 02:04:02PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's the patch to fix the io_edgeport driver.  Johannes, please send
this to Linus, it's against 2.4.5-pre5.

thanks,

greg k-h

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-io_edgeport-2.4.5-pre5.patch"

diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Thu May 24 23:18:56 2001
+++ b/drivers/usb/serial/io_edgeport.c	Thu May 24 23:18:56 2001
@@ -944,7 +944,7 @@
 	}
 
 	if (status) {
-		dbg(__FUNCTION__" - nonzero write bulk status received: %d", urb->status);
+		dbg(__FUNCTION__" - nonzero write bulk status received: %d", status);
 		return;
 	}
 

--gBBFr7Ir9EOA20Yy--
