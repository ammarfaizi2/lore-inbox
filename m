Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTFEUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFEUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:05:29 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:53464 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265089AbTFEUFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:05:21 -0400
Date: Thu, 5 Jun 2003 22:18:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk9 zlib cleanup #3 ZEXPORT
Message-ID: <20030605201850.GC22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <20030605200958.GB22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030605200958.GB22439@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Just a simple s/ZEXPORT//.

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius

--- linux-2.5.70-bk9/lib/zlib_inflate/inflate.c~zlib_cleanup_ZEXPORT	2003-06-05 22:12:38.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inflate.c	2003-06-05 22:13:00.000000000 +0200
@@ -9,13 +9,13 @@
 #include "infutil.h"
 
 
-int ZEXPORT zlib_inflate_workspacesize(void)
+int zlib_inflate_workspacesize(void)
 {
   return sizeof(struct inflate_workspace);
 }
 
 
-int ZEXPORT zlib_inflateReset(
+int zlib_inflateReset(
 	z_streamp z
 )
 {
@@ -29,7 +29,7 @@
 }
 
 
-int ZEXPORT zlib_inflateEnd(
+int zlib_inflateEnd(
 	z_streamp z
 )
 {
@@ -43,7 +43,7 @@
 }
 
 
-int ZEXPORT zlib_inflateInit2_(
+int zlib_inflateInit2_(
 	z_streamp z,
 	int w,
 	const char *version,
@@ -106,7 +106,7 @@
 }
 
 
-int ZEXPORT zlib_inflateInit_(
+int zlib_inflateInit_(
 	z_streamp z,
 	const char *version,
 	int stream_size
@@ -120,7 +120,7 @@
 #define NEEDBYTE {if(z->avail_in==0)goto empty;r=trv;}
 #define NEXTBYTE (z->avail_in--,z->total_in++,*z->next_in++)
 
-int ZEXPORT zlib_inflate(
+int zlib_inflate(
 	z_streamp z,
 	int f
 )
@@ -253,7 +253,7 @@
 }
 
 
-int ZEXPORT zlib_inflateSync(
+int zlib_inflateSync(
 	z_streamp z
 )
 {
@@ -312,7 +312,7 @@
  * decompressing, PPP checks that at the end of input packet, inflate is
  * waiting for these length bytes.
  */
-int ZEXPORT zlib_inflateSyncPoint(
+int zlib_inflateSyncPoint(
 	z_streamp z
 )
 {
@@ -383,7 +383,7 @@
  * will have been updated if need be.
  */
 
-int ZEXPORT zlib_inflateIncomp(
+int zlib_inflateIncomp(
 	z_stream *z
 	
 )
--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_ZEXPORT	2003-06-05 22:12:38.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 22:13:00.000000000 +0200
@@ -57,13 +57,6 @@
 #  endif
 #endif
 
-#ifndef ZEXPORT
-#  define ZEXPORT
-#endif
-#ifndef ZEXPORTVA
-#  define ZEXPORTVA
-#endif
-
 typedef unsigned char  Byte;  /* 8 bits */
 typedef unsigned int   uInt;  /* 16 bits or more */
 typedef unsigned long  uLong; /* 32 bits or more */
--- linux-2.5.70-bk9/include/linux/zlib.h~zlib_cleanup_ZEXPORT	2003-06-05 22:12:38.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zlib.h	2003-06-05 22:13:00.000000000 +0200
@@ -162,7 +162,7 @@
 
                         /* basic functions */
 
-extern const char * ZEXPORT zlib_zlibVersion OF((void));
+extern const char * zlib_zlibVersion OF((void));
 /* The application can compare zlibVersion and ZLIB_VERSION for consistency.
    If the first character differs, the library code actually used is
    not compatible with the zlib.h header file used by the application.
@@ -181,7 +181,7 @@
 */
 
 
-extern int ZEXPORT zlib_deflate_workspacesize OF((void));
+extern int zlib_deflate_workspacesize OF((void));
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -189,7 +189,7 @@
 */
 
 /* 
-extern int ZEXPORT deflateInit OF((z_streamp strm, int level));
+extern int deflateInit OF((z_streamp strm, int level));
 
      Initializes the internal stream state for compression. The fields
    zalloc, zfree and opaque must be initialized before by the caller.
@@ -211,7 +211,7 @@
 */
 
 
-extern int ZEXPORT zlib_deflate OF((z_streamp strm, int flush));
+extern int zlib_deflate OF((z_streamp strm, int flush));
 /*
     deflate compresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may introduce some
@@ -289,7 +289,7 @@
 */
 
 
-extern int ZEXPORT zlib_deflateEnd OF((z_streamp strm));
+extern int zlib_deflateEnd OF((z_streamp strm));
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -303,7 +303,7 @@
 */
 
 
-extern int ZEXPORT zlib_inflate_workspacesize OF((void));
+extern int zlib_inflate_workspacesize OF((void));
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -311,7 +311,7 @@
 */
 
 /* 
-extern int ZEXPORT zlib_inflateInit OF((z_streamp strm));
+extern int zlib_inflateInit OF((z_streamp strm));
 
      Initializes the internal stream state for decompression. The fields
    next_in, avail_in, and workspace must be initialized before by
@@ -331,7 +331,7 @@
 */
 
 
-extern int ZEXPORT zlib_inflate OF((z_streamp strm, int flush));
+extern int zlib_inflate OF((z_streamp strm, int flush));
 /*
     inflate decompresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may some
@@ -400,7 +400,7 @@
 */
 
 
-extern int ZEXPORT zlib_inflateEnd OF((z_streamp strm));
+extern int zlib_inflateEnd OF((z_streamp strm));
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -418,7 +418,7 @@
 */
 
 /*   
-extern int ZEXPORT deflateInit2 OF((z_streamp strm,
+extern int deflateInit2 OF((z_streamp strm,
                                      int  level,
                                      int  method,
                                      int  windowBits,
@@ -461,7 +461,7 @@
    not perform any compression: this will be done by deflate().
 */
                             
-extern int ZEXPORT zlib_deflateSetDictionary OF((z_streamp strm,
+extern int zlib_deflateSetDictionary OF((z_streamp strm,
 						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
@@ -497,7 +497,7 @@
    perform any compression: this will be done by deflate().
 */
 
-extern int ZEXPORT zlib_deflateCopy OF((z_streamp dest,
+extern int zlib_deflateCopy OF((z_streamp dest,
 					    z_streamp source));
 /*
      Sets the destination stream as a complete copy of the source stream.
@@ -515,7 +515,7 @@
    destination.
 */
 
-extern int ZEXPORT zlib_deflateReset OF((z_streamp strm));
+extern int zlib_deflateReset OF((z_streamp strm));
 /*
      This function is equivalent to deflateEnd followed by deflateInit,
    but does not free and reallocate all the internal compression state.
@@ -526,7 +526,7 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
-extern int ZEXPORT zlib_deflateParams OF((z_streamp strm,
+extern int zlib_deflateParams OF((z_streamp strm,
 					      int level,
 					      int strategy));
 /*
@@ -548,7 +548,7 @@
 */
 
 /*   
-extern int ZEXPORT inflateInit2 OF((z_streamp strm,
+extern int inflateInit2 OF((z_streamp strm,
                                      int  windowBits));
 
      This is another version of inflateInit with an extra parameter. The
@@ -570,7 +570,7 @@
    modified, but next_out and avail_out are unchanged.)
 */
 
-extern int ZEXPORT zlib_inflateSetDictionary OF((z_streamp strm,
+extern int zlib_inflateSetDictionary OF((z_streamp strm,
 						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
@@ -589,7 +589,7 @@
    inflate().
 */
 
-extern int ZEXPORT zlib_inflateSync OF((z_streamp strm));
+extern int zlib_inflateSync OF((z_streamp strm));
 /* 
     Skips invalid compressed data until a full flush point (see above the
   description of deflate with Z_FULL_FLUSH) can be found, or until all
@@ -604,7 +604,7 @@
   until success or end of the input data.
 */
 
-extern int ZEXPORT zlib_inflateReset OF((z_streamp strm));
+extern int zlib_inflateReset OF((z_streamp strm));
 /*
      This function is equivalent to inflateEnd followed by inflateInit,
    but does not free and reallocate all the internal decompression state.
@@ -614,7 +614,7 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
-extern int ZEXPORT zlib_inflateIncomp OF((z_stream *strm));
+extern int zlib_inflateIncomp OF((z_stream *strm));
 /*
      This function adds the data at next_in (avail_in bytes) to the output
    history without performing any output.  There must be no pending output,
@@ -628,15 +628,15 @@
 /* deflateInit and inflateInit are macros to allow checking the zlib version
  * and the compiler's view of z_stream:
  */
-extern int ZEXPORT zlib_deflateInit_ OF((z_streamp strm, int level,
+extern int zlib_deflateInit_ OF((z_streamp strm, int level,
                                      const char *version, int stream_size));
-extern int ZEXPORT zlib_inflateInit_ OF((z_streamp strm,
+extern int zlib_inflateInit_ OF((z_streamp strm,
                                      const char *version, int stream_size));
-extern int ZEXPORT zlib_deflateInit2_ OF((z_streamp strm, int  level, int  method,
+extern int zlib_deflateInit2_ OF((z_streamp strm, int  level, int  method,
                                       int windowBits, int memLevel,
                                       int strategy, const char *version,
                                       int stream_size));
-extern int ZEXPORT zlib_inflateInit2_ OF((z_streamp strm, int  windowBits,
+extern int zlib_inflateInit2_ OF((z_streamp strm, int  windowBits,
                                       const char *version, int stream_size));
 #define zlib_deflateInit(strm, level) \
         zlib_deflateInit_((strm), (level), ZLIB_VERSION, sizeof(z_stream))
@@ -653,9 +653,9 @@
     struct internal_state {int dummy;}; /* hack for buggy compilers */
 #endif
 
-extern const char  * ZEXPORT zlib_zError           OF((int err));
-extern int           ZEXPORT zlib_inflateSyncPoint OF((z_streamp z));
-extern const uLong * ZEXPORT zlib_get_crc_table    OF((void));
+extern const char  * zlib_zError           OF((int err));
+extern int           zlib_inflateSyncPoint OF((z_streamp z));
+extern const uLong * zlib_get_crc_table    OF((void));
 
 #ifdef __cplusplus
 }
--- linux-2.5.70-bk9/include/linux/zutil.h~zlib_cleanup_ZEXPORT	2003-06-05 22:12:38.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zutil.h	2003-06-05 22:13:00.000000000 +0200
@@ -62,7 +62,7 @@
 
          /* functions */
 
-typedef uLong (ZEXPORT *check_func) OF((uLong check, const Byte *buf,
+typedef uLong (*check_func) OF((uLong check, const Byte *buf,
 				       uInt len));
 
 
--- linux-2.5.70-bk9/lib/zlib_deflate/deflate.c~zlib_cleanup_ZEXPORT	2003-06-05 21:59:09.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deflate.c	2003-06-05 22:14:09.000000000 +0200
@@ -1255,7 +1255,7 @@
     return flush == Z_FINISH ? finish_done : block_done;
 }
 
-extern int ZEXPORT zlib_deflate_workspacesize ()
+extern int zlib_deflate_workspacesize ()
 {
     return sizeof(deflate_workspace);
 }
