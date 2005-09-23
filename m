Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVIWVqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVIWVqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIWVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:46:40 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:58510 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVIWVqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:46:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ODFmVBNspvigsaXxHpd3TC6K+5vXdOwUT86dwucjwTVBHByFf8k0VCf22LeLylhXwG5cCI2eJYWuBWpXyFbBUhjNk/dzeMMaiVsajyCXpVQPYJEnThwWjvoJ2p7jbK5fnOJjmnUx+TVENIAoeIJ5wziuLHs8ViOOtyNMTFCDp0Y=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] lib/string.c cleanup : whitespace and CodingStyle cleanups
Date: Fri, 23 Sep 2005 23:48:44 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Oeser <ioe@informatik.tu-chemnitz.de>,
       Jason Thomas <jason@topic.com.au>,
       Matthew Hawkins <matt@mh.dropbear.id.au>
References: <200509232344.26044.jesper.juhl@gmail.com>
In-Reply-To: <200509232344.26044.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232348.45030.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace and CodingStyle cleanups for lib/string.c

Removes some blank lines, removes some trailing whitespace, adds spaces 
after commas and a few similar changes.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
--- 

 lib/string.c |  113 +++++++++++++++++++++++++++--------------------------------
 1 files changed, 53 insertions(+), 60 deletions(-)

--- linux-2.6.14-rc2-git3/lib/string.c.orig	2005-09-23 22:25:47.000000000 +0200
+++ linux-2.6.14-rc2-git3/lib/string.c	2005-09-23 22:39:57.000000000 +0200
@@ -39,8 +39,10 @@ int strnicmp(const char *s1, const char 
 	c1 = 0;	c2 = 0;
 	if (len) {
 		do {
-			c1 = *s1; c2 = *s2;
-			s1++; s2++;
+			c1 = *s1;
+			c2 = *s2;
+			s1++;
+			s2++;
 			if (!c1)
 				break;
 			if (!c2)
@@ -55,7 +57,6 @@ int strnicmp(const char *s1, const char 
 	}
 	return (int)c1 - (int)c2;
 }
-
 EXPORT_SYMBOL(strnicmp);
 #endif
 
@@ -66,7 +67,7 @@ EXPORT_SYMBOL(strnicmp);
  * @src: Where to copy the string from
  */
 #undef strcpy
-char * strcpy(char * dest,const char *src)
+char *strcpy(char *dest, const char *src)
 {
 	char *tmp = dest;
 
@@ -91,12 +92,13 @@ EXPORT_SYMBOL(strcpy);
  * count, the remainder of @dest will be padded with %NUL.
  *
  */
-char * strncpy(char * dest,const char *src,size_t count)
+char *strncpy(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 
 	while (count) {
-		if ((*tmp = *src) != 0) src++;
+		if ((*tmp = *src) != 0)
+			src++;
 		tmp++;
 		count--;
 	}
@@ -122,7 +124,7 @@ size_t strlcpy(char *dest, const char *s
 	size_t ret = strlen(src);
 
 	if (size) {
-		size_t len = (ret >= size) ? size-1 : ret;
+		size_t len = (ret >= size) ? size - 1 : ret;
 		memcpy(dest, src, len);
 		dest[len] = '\0';
 	}
@@ -138,7 +140,7 @@ EXPORT_SYMBOL(strlcpy);
  * @src: The string to append to it
  */
 #undef strcat
-char * strcat(char * dest, const char * src)
+char *strcat(char *dest, const char *src)
 {
 	char *tmp = dest;
 
@@ -162,7 +164,7 @@ EXPORT_SYMBOL(strcat);
  * Note that in contrast to strncpy, strncat ensures the result is
  * terminated.
  */
-char * strncat(char *dest, const char *src, size_t count)
+char *strncat(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 
@@ -176,7 +178,6 @@ char * strncat(char *dest, const char *s
 			}
 		}
 	}
-
 	return tmp;
 }
 EXPORT_SYMBOL(strncat);
@@ -216,7 +217,7 @@ EXPORT_SYMBOL(strlcat);
  * @ct: Another string
  */
 #undef strcmp
-int strcmp(const char * cs,const char * ct)
+int strcmp(const char *cs, const char *ct)
 {
 	register signed char __res;
 
@@ -224,7 +225,6 @@ int strcmp(const char * cs,const char * 
 		if ((__res = *cs - *ct++) != 0 || !*cs++)
 			break;
 	}
-
 	return __res;
 }
 EXPORT_SYMBOL(strcmp);
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(strcmp);
  * @ct: Another string
  * @count: The maximum number of bytes to compare
  */
-int strncmp(const char * cs,const char * ct,size_t count)
+int strncmp(const char *cs, const char *ct, size_t count)
 {
 	register signed char __res = 0;
 
@@ -246,7 +246,6 @@ int strncmp(const char * cs,const char *
 			break;
 		count--;
 	}
-
 	return __res;
 }
 EXPORT_SYMBOL(strncmp);
@@ -258,12 +257,12 @@ EXPORT_SYMBOL(strncmp);
  * @s: The string to be searched
  * @c: The character to search for
  */
-char * strchr(const char * s, int c)
+char *strchr(const char *s, int c)
 {
-	for(; *s != (char) c; ++s)
+	for (; *s != (char)c; ++s)
 		if (*s == '\0')
 			return NULL;
-	return (char *) s;
+	return (char *)s;
 }
 EXPORT_SYMBOL(strchr);
 #endif
@@ -274,7 +273,7 @@ EXPORT_SYMBOL(strchr);
  * @s: The string to be searched
  * @c: The character to search for
  */
-char * strrchr(const char * s, int c)
+char *strrchr(const char *s, int c)
 {
        const char *p = s + strlen(s);
        do {
@@ -296,8 +295,8 @@ EXPORT_SYMBOL(strrchr);
 char *strnchr(const char *s, size_t count, int c)
 {
 	for (; count-- && *s != '\0'; ++s)
-		if (*s == (char) c)
-			return (char *) s;
+		if (*s == (char)c)
+			return (char *)s;
 	return NULL;
 }
 EXPORT_SYMBOL(strnchr);
@@ -308,7 +307,7 @@ EXPORT_SYMBOL(strnchr);
  * strlen - Find the length of a string
  * @s: The string to be sized
  */
-size_t strlen(const char * s)
+size_t strlen(const char *s)
 {
 	const char *sc;
 
@@ -325,7 +324,7 @@ EXPORT_SYMBOL(strlen);
  * @s: The string to be sized
  * @count: The maximum number of bytes to search
  */
-size_t strnlen(const char * s, size_t count)
+size_t strnlen(const char *s, size_t count)
 {
 	const char *sc;
 
@@ -358,7 +357,6 @@ size_t strspn(const char *s, const char 
 			return count;
 		++count;
 	}
-
 	return count;
 }
 
@@ -384,9 +382,8 @@ size_t strcspn(const char *s, const char
 		}
 		++count;
 	}
-
 	return count;
-}	
+}
 EXPORT_SYMBOL(strcspn);
 
 #ifndef __HAVE_ARCH_STRPBRK
@@ -395,14 +392,14 @@ EXPORT_SYMBOL(strcspn);
  * @cs: The string to be searched
  * @ct: The characters to search for
  */
-char * strpbrk(const char * cs,const char * ct)
+char *strpbrk(const char *cs, const char *ct)
 {
-	const char *sc1,*sc2;
+	const char *sc1, *sc2;
 
-	for( sc1 = cs; *sc1 != '\0'; ++sc1) {
-		for( sc2 = ct; *sc2 != '\0'; ++sc2) {
+	for (sc1 = cs; *sc1 != '\0'; ++sc1) {
+		for (sc2 = ct; *sc2 != '\0'; ++sc2) {
 			if (*sc1 == *sc2)
-				return (char *) sc1;
+				return (char *)sc1;
 		}
 	}
 	return NULL;
@@ -422,9 +419,10 @@ EXPORT_SYMBOL(strpbrk);
  * of that name. In fact, it was stolen from glibc2 and de-fancy-fied.
  * Same semantics, slimmer shape. ;)
  */
-char * strsep(char **s, const char *ct)
+char *strsep(char **s, const char *ct)
 {
-	char *sbegin = *s, *end;
+	char *sbegin = *s;
+	char *end;
 
 	if (sbegin == NULL)
 		return NULL;
@@ -433,10 +431,8 @@ char * strsep(char **s, const char *ct)
 	if (end)
 		*end++ = '\0';
 	*s = end;
-
 	return sbegin;
 }
-
 EXPORT_SYMBOL(strsep);
 #endif
 
@@ -449,13 +445,12 @@ EXPORT_SYMBOL(strsep);
  *
  * Do not use memset() to access IO space, use memset_io() instead.
  */
-void * memset(void * s,int c,size_t count)
+void *memset(void *s, int c, size_t count)
 {
-	char *xs = (char *) s;
+	char *xs = (char *)s;
 
 	while (count--)
 		*xs++ = c;
-
 	return s;
 }
 EXPORT_SYMBOL(memset);
@@ -471,13 +466,13 @@ EXPORT_SYMBOL(memset);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-void * memcpy(void * dest,const void *src,size_t count)
+void *memcpy(void *dest, const void *src, size_t count)
 {
-	char *tmp = (char *) dest, *s = (char *) src;
+	char *tmp = (char *)dest;
+	char *s = (char *)src;
 
 	while (count--)
 		*tmp++ = *s++;
-
 	return dest;
 }
 EXPORT_SYMBOL(memcpy);
@@ -492,23 +487,21 @@ EXPORT_SYMBOL(memcpy);
  *
  * Unlike memcpy(), memmove() copes with overlapping areas.
  */
-void * memmove(void * dest,const void *src,size_t count)
+void *memmove(void *dest, const void *src, size_t count)
 {
 	char *tmp, *s;
 
 	if (dest <= src) {
-		tmp = (char *) dest;
-		s = (char *) src;
+		tmp = (char *)dest;
+		s = (char *)src;
 		while (count--)
 			*tmp++ = *s++;
-		}
-	else {
-		tmp = (char *) dest + count;
-		s = (char *) src + count;
+	} else {
+		tmp = (char *)dest + count;
+		s = (char *)src + count;
 		while (count--)
 			*--tmp = *--s;
-		}
-
+	}
 	return dest;
 }
 EXPORT_SYMBOL(memmove);
@@ -522,12 +515,12 @@ EXPORT_SYMBOL(memmove);
  * @count: The size of the area.
  */
 #undef memcmp
-int memcmp(const void * cs,const void * ct,size_t count)
+int memcmp(const void *cs, const void *ct, size_t count)
 {
 	const unsigned char *su1, *su2;
 	int res = 0;
 
-	for( su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
 		if ((res = *su1 - *su2) != 0)
 			break;
 	return res;
@@ -545,17 +538,17 @@ EXPORT_SYMBOL(memcmp);
  * returns the address of the first occurrence of @c, or 1 byte past
  * the area if @c is not found
  */
-void * memscan(void * addr, int c, size_t size)
+void *memscan(void *addr, int c, size_t size)
 {
-	unsigned char * p = (unsigned char *) addr;
+	unsigned char *p = (unsigned char *)addr;
 
 	while (size) {
 		if (*p == c)
-			return (void *) p;
+			return (void *)p;
 		p++;
 		size--;
 	}
-  	return (void *) p;
+  	return (void *)p;
 }
 EXPORT_SYMBOL(memscan);
 #endif
@@ -566,18 +559,18 @@ EXPORT_SYMBOL(memscan);
  * @s1: The string to be searched
  * @s2: The string to search for
  */
-char * strstr(const char * s1,const char * s2)
+char *strstr(const char *s1, const char *s2)
 {
 	int l1, l2;
 
 	l2 = strlen(s2);
 	if (!l2)
-		return (char *) s1;
+		return (char *)s1;
 	l1 = strlen(s1);
 	while (l1 >= l2) {
 		l1--;
-		if (!memcmp(s1,s2,l2))
-			return (char *) s1;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
 		s1++;
 	}
 	return NULL;
@@ -600,7 +593,7 @@ void *memchr(const void *s, int c, size_
 	const unsigned char *p = s;
 	while (n-- != 0) {
         	if ((unsigned char)c == *p++) {
-			return (void *)(p-1);
+			return (void *)(p - 1);
 		}
 	}
 	return NULL;


