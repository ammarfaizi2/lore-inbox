Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314328AbSDVRms>; Mon, 22 Apr 2002 13:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314329AbSDVRmr>; Mon, 22 Apr 2002 13:42:47 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:25314 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314328AbSDVRmp>; Mon, 22 Apr 2002 13:42:45 -0400
Date: Mon, 22 Apr 2002 10:42:40 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <greearb@candelatech.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: novice coding in /linux/net/ipv4/util.c
Message-ID: <Pine.LNX.4.33.0204221008580.32371-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in_ntoa() should be obsolete. The current policy seems to
be to have everybody use NIPQUAD directly..

They seem to have axed the reentrant in_ntoa2()
between 2.3.99 and 2.4.0:

--- linux-2.3.99/net/ipv4/utils.c       Wed Jun  9 14:45:37 1999
+++ linux-2.4.0/net/ipv4/utils.c        Tue Oct 10 10:33:52 2000
@@ -6,7 +6,7 @@
  *             Various kernel-resident INET utility functions; mainly
  *             for format conversion and debugging output.
  *
- * Version:    $Id: utils.c,v 1.7 1999/06/09 10:11:05 davem Exp $
+ * Version:    $Id: utils.c,v 1.8 2000/10/03 07:29:01 anton Exp $
  *
  * Author:     Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
  *
@@ -57,12 +57,6 @@
        return(buff);
 }
 
-char *in_ntoa2(__u32 in, char *buff)
-{
-       sprintf(buff, "%d.%d.%d.%d", NIPQUAD(in));
-       return buff;
-}
-
 /*
  *     Convert an ASCII string to binary IP. 
  */

