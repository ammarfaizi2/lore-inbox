Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSFJMut>; Mon, 10 Jun 2002 08:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSFJMuG>; Mon, 10 Jun 2002 08:50:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31239 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313898AbSFJMsb>; Mon, 10 Jun 2002 08:48:31 -0400
Message-ID: <3D04925E.1070502@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:49:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 18/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090706030003080705000305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090706030003080705000305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Slowly we get there...

--------------090706030003080705000305
Content-Type: text/plain;
 name="warn-2.5.21-18.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-18.diff"

diff -urN linux-2.5.21/net/irda/parameters.c linux/net/irda/parameters.c
--- linux-2.5.21/net/irda/parameters.c	2002-06-09 07:30:51.000000000 +0200
+++ linux/net/irda/parameters.c	2002-06-09 20:38:32.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *                
+ *
  * Filename:      parameters.c
  * Version:       1.0
  * Description:   A more general way to handle (pi,pl,pv) parameters
@@ -8,24 +8,24 @@
  * Created at:    Mon Jun  7 10:25:11 1999
  * Modified at:   Sun Jan 30 14:08:39 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
+ *
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
- *     
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- * 
+ *
  *     This program is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *     GNU General Public License for more details.
- * 
- *     You should have received a copy of the GNU General Public License 
- *     along with this program; if not, write to the Free Software 
- *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program; if not, write to the Free Software
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  *     MA 02111-1307 USA
- *     
+ *
  ********************************************************************/
 
 #include <linux/types.h>
@@ -35,18 +35,18 @@
 #include <net/irda/irda.h>
 #include <net/irda/parameters.h>
 
-static int irda_extract_integer(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_integer(void *self, __u8 *buf, int len, __u8 pi,
 				PV_TYPE type, PI_HANDLER func);
-static int irda_extract_string(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_string(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func);
-static int irda_extract_octseq(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_octseq(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func);
-static int irda_extract_no_value(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_no_value(void *self, __u8 *buf, int len, __u8 pi,
 				 PV_TYPE type, PI_HANDLER func);
 
-static int irda_insert_integer(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_insert_integer(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func);
-static int irda_insert_no_value(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_insert_no_value(void *self, __u8 *buf, int len, __u8 pi,
 				PV_TYPE type, PI_HANDLER func);
 
 /* Parameter value call table. Must match PV_TYPE */
@@ -72,11 +72,8 @@
 
 /*
  * Function irda_insert_no_value (self, buf, len, pi, type, func)
- *
- *    
- *
  */
-static int irda_insert_no_value(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_insert_no_value(void *self, __u8 *buf, int len, __u8 pi,
 				PV_TYPE type, PI_HANDLER func)
 {
 	irda_param_t p;
@@ -93,7 +90,7 @@
 
 	if (ret < 0)
 		return ret;
-	 
+
 	return 2; /* Inserted pl+2 bytes */
 }
 
@@ -103,7 +100,7 @@
  *    Extracts a parameter without a pv field (pl=0)
  *
  */
-static int irda_extract_no_value(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_no_value(void *self, __u8 *buf, int len, __u8 pi,
 				 PV_TYPE type, PI_HANDLER func)
 {
 	irda_param_t p;
@@ -117,17 +114,14 @@
 
 	if (ret < 0)
 		return ret;
-	 
+
 	return 2; /* Extracted pl+2 bytes */
 }
 
 /*
  * Function irda_insert_integer (self, buf, len, pi, type, func)
- *
- *    
- *
  */
-static int irda_insert_integer(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_insert_integer(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func)
 {
 	irda_param_t p;
@@ -141,10 +135,10 @@
 	/* Call handler for this parameter */
 	err = (*func)(self, &p, PV_GET);
 	if (err < 0)
-		return err; 
+		return err;
 
-	/* 
-	 * If parameter lenght is still 0, then (1) this is an any length 
+	/*
+	 * If parameter lenght is still 0, then (1) this is an any length
 	 * integer, and (2) the handler function does not care which length
 	 * we choose to use, so we pick the one the gives the fewest bytes.
 	 */
@@ -162,7 +156,7 @@
 	}
 	/* Check if buffer is long enough for insertion */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for insertion!\n");
+		WARNING("%s: buffer to short for insertion!\n", __FUNCTION__);
 		return -1;
 	}
 	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
@@ -186,8 +180,8 @@
 
 		break;
 	default:
-		WARNING(__FUNCTION__ "() length %d not supported\n", p.pl);
-		/* Skip parameter */ 
+		WARNING("%s: length %d not supported\n", __FUNCTION__, p.pl);
+		/* Skip parameter */
 		return -1;
 	}
 
@@ -197,10 +191,10 @@
 /*
  * Function irda_extract integer (self, buf, len, pi, type, func)
  *
- *    Extract a possibly variable length integer from buffer, and call 
+ *    Extract a possibly variable length integer from buffer, and call
  *    handler for processing of the parameter
  */
-static int irda_extract_integer(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_integer(void *self, __u8 *buf, int len, __u8 pi,
 				PV_TYPE type, PI_HANDLER func)
 {
 	irda_param_t p;
@@ -213,20 +207,21 @@
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s: buffer to short for parsing! "
+			"Need %d bytes, but len is only %d\n",
+			__FUNCTION__, p.pl, len);
 		return -1;
 	}
 
-	/* 
+	/*
 	 * Check that the integer length is what we expect it to be. If the
 	 * handler want a 16 bits integer then a 32 bits is not good enough
 	 */
 	if (((type & PV_MASK) != PV_INTEGER) && ((type & PV_MASK) != p.pl)) {
-		ERROR(__FUNCTION__ "(), invalid parameter length! "
+		ERROR("%s: invalid parameter length! "
 		      "Expected %d bytes, but value had %d bytes!\n",
-		      type & PV_MASK, p.pl);
-		
+		      __FUNCTION__, type & PV_MASK, p.pl);
+
 		/* Skip parameter */
 		return p.pl+2;
 	}
@@ -251,9 +246,9 @@
 			le32_to_cpus(&p.pv.i);
 		break;
 	default:
-		WARNING(__FUNCTION__ "() length %d not supported\n", p.pl);
+		WARNING("%s: length %d not supported\n", __FUNCTION__, p.pl);
 
-		/* Skip parameter */ 
+		/* Skip parameter */
 		return p.pl+2;
 	}
 
@@ -261,18 +256,15 @@
 	/* Call handler for this parameter */
 	err = (*func)(self, &p, PV_PUT);
 	if (err < 0)
-		return err; 
+		return err;
 
 	return p.pl+2; /* Extracted pl+2 bytes */
 }
 
 /*
  * Function irda_extract_string (self, buf, len, type, func)
- *
- *    
- *
  */
-static int irda_extract_string(void *self, __u8 *buf, int len, __u8 pi, 
+static int irda_extract_string(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func)
 {
 	char str[33];
@@ -288,18 +280,19 @@
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s: buffer to short for parsing! "
+			"Need %d bytes, but len is only %d\n",
+			__FUNCTION__, p.pl, len);
 		return -1;
 	}
 
-	/* Should be safe to copy string like this since we have already 
+	/* Should be safe to copy string like this since we have already
 	 * checked that the buffer is long enough */
 	strncpy(str, buf+2, p.pl);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), str=0x%02x 0x%02x\n", (__u8) str[0], 
+	IRDA_DEBUG(2, __FUNCTION__ "(), str=0x%02x 0x%02x\n", (__u8) str[0],
 	      (__u8) str[1]);
-	
+
 	/* Null terminate string */
 	str[p.pl+1] = '\0';
 
@@ -308,16 +301,13 @@
 	/* Call handler for this parameter */
 	err = (*func)(self, &p, PV_PUT);
 	if (err < 0)
-		return err; 
+		return err;
 
 	return p.pl+2; /* Extracted pl+2 bytes */
 }
 
 /*
  * Function irda_extract_octseq (self, buf, len, type, func)
- *
- *    
- *
  */
 static int irda_extract_octseq(void *self, __u8 *buf, int len, __u8 pi,
 			       PV_TYPE type, PI_HANDLER func)
@@ -329,13 +319,14 @@
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s: buffer to short for parsing! "
+			"Need %d bytes, but len is only %d\n",
+			__FUNCTION__, p.pl, len);
 		return -1;
 	}
 
 	IRDA_DEBUG(0, __FUNCTION__ "(), not impl\n");
-	
+
 	return p.pl+2; /* Extracted pl+2 bytes */
 }
 
@@ -353,7 +344,7 @@
 	va_list args;
 	char *p;
 	int n = 0;
-	
+
 	va_start(args, fmt);
 
 	for (p = fmt; *p != '\0'; p++) {
@@ -380,7 +371,6 @@
 			va_end(args);
 			return -1;
 		}
-		
 	}
 	va_end(args);
 
@@ -389,9 +379,6 @@
 
 /*
  * Function irda_param_unpack (skb, fmt, ...)
- *
- *    
- *
  */
 int irda_param_unpack(__u8 *buf, char *fmt, ...)
 {
@@ -427,7 +414,7 @@
 			va_end(args);
 			return -1;
 		}
-		
+
 	}
 	va_end(args);
 
@@ -440,7 +427,7 @@
  *    Insert the specified parameter (pi) into buffer. Returns number of
  *    bytes inserted
  */
-int irda_param_insert(void *self, __u8 pi, __u8 *buf, int len, 
+int irda_param_insert(void *self, __u8 pi, __u8 *buf, int len,
 		      pi_param_info_t *info)
 {
 	pi_minor_info_t *pi_minor_info;
@@ -457,16 +444,16 @@
 	pi_major = pi >> info->pi_major_offset;
 
 	/* Check if the identifier value (pi) is valid */
-	if ((pi_major > info->len-1) || 
+	if ((pi_major > info->len-1) ||
 	    (pi_minor > info->tables[pi_major].len-1))
 	{
-		IRDA_DEBUG(0, __FUNCTION__ 
+		IRDA_DEBUG(0, __FUNCTION__
 		      "(), no handler for parameter=0x%02x\n", pi);
-		
+
 		/* Skip this parameter */
 		return -1;
 	}
-	
+
 	/* Lookup the info on how to parse this parameter */
 	pi_minor_info = &info->tables[pi_major].pi_minor_call_table[pi_minor];
 
@@ -475,13 +462,13 @@
 
 	/*  Check if handler has been implemented */
 	if (!pi_minor_info->func) {
-		MESSAGE(__FUNCTION__"(), no handler for pi=%#x\n", pi);
+		MESSAGE("%s: no handler for pi=%#x\n", __FUNCTION__, pi);
 		/* Skip this parameter */
 		return -1;
 	}
-	
+
 	/* Insert parameter value */
-	ret = (*pv_insert_table[type & PV_MASK])(self, buf+n, len, pi, type, 
+	ret = (*pv_insert_table[type & PV_MASK])(self, buf+n, len, pi, type,
 						 pi_minor_info->func);
 	return ret;
 }
@@ -507,14 +494,14 @@
 
 	pi_minor = buf[n] & info->pi_mask;
 	pi_major = buf[n] >> info->pi_major_offset;
-	
+
 	/* Check if the identifier value (pi) is valid */
-	if ((pi_major > info->len-1) || 
+	if ((pi_major > info->len-1) ||
 	    (pi_minor > info->tables[pi_major].len-1))
 	{
 		IRDA_DEBUG(0, __FUNCTION__ "(), no handler for parameter=0x%02x\n",
 		      buf[0]);
-		
+
 		/* Skip this parameter */
 		return 2 + buf[n + 1];  /* Continue */
 	}
@@ -524,13 +511,13 @@
 
 	/* Find expected data type for this parameter identifier (pi)*/
 	type = pi_minor_info->type;
-	
+
 	IRDA_DEBUG(3, __FUNCTION__ "(), pi=[%d,%d], type=%d\n",
 	      pi_major, pi_minor, type);
-	
+
 	/*  Check if handler has been implemented */
 	if (!pi_minor_info->func) {
-		MESSAGE(__FUNCTION__"(), no handler for pi=%#x\n", buf[n]);
+		MESSAGE("%s: no handler for pi=%#x\n", __FUNCTION__, buf[n]);
 		/* Skip this parameter */
 		return 2 + buf[n + 1]; /* Continue */
 	}

--------------090706030003080705000305--

