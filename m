Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTJZNtL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTJZNtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:49:11 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:14090 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S263171AbTJZNtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:49:05 -0500
Date: Sun, 26 Oct 2003 14:48:58 +0100
From: David Jez <dave.jez@seznam.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diethotplug-0.4 utility patch
Message-ID: <20031026134858.GA59277@stud.fit.vutbr.cz>
References: <20031023184603.GA81234@stud.fit.vutbr.cz> <20031024054145.GA3233@kroah.com> <20031025120422.GB93355@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20031025120422.GB93355@stud.fit.vutbr.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > > - for USB: matching by vendor & class, not only by vendor (-ENODEV bug)
> > 
> > Can you split this patch out?  It looks useful.
>   of course
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diethotplug-0.4.diff"

diff -urN diethotplug-0.4.orig/ieee1394.c diethotplug-0.4/ieee1394.c
--- diethotplug-0.4.orig/ieee1394.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/ieee1394.c	Sat Oct 25 20:36:12 2003
@@ -75,7 +75,7 @@
 			return retval;
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 
diff -urN diethotplug-0.4.orig/usb.c diethotplug-0.4/usb.c
--- diethotplug-0.4.orig/usb.c	Wed Jan  9 20:57:29 2002
+++ diethotplug-0.4/usb.c	Sat Oct 25 20:36:07 2003
@@ -84,7 +84,7 @@
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 	
 
@@ -121,7 +121,7 @@
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 
@@ -158,7 +158,7 @@
 		}
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 

--mP3DRpeJDSE+ciuQ--
