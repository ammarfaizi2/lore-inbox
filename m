Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTFET4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTFET4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:56:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:34519 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264956AbTFET43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:56:29 -0400
Date: Thu, 5 Jun 2003 22:09:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk9 zlib cleanup #2 ZEXTERN
Message-ID: <20030605200958.GB22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030605194644.GA22439@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This one was just simple s/ZEXTERN/extern/g.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson

--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_ZEXTERN	2003-06-05 21:35:04.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 22:00:53.000000000 +0200
@@ -63,9 +63,6 @@
 #ifndef ZEXPORTVA
 #  define ZEXPORTVA
 #endif
-#ifndef ZEXTERN
-#  define ZEXTERN extern
-#endif
 
 typedef unsigned char  Byte;  /* 8 bits */
 typedef unsigned int   uInt;  /* 16 bits or more */
--- linux-2.5.70-bk9/lib/zlib_deflate/deflate.c~zlib_cleanup_ZEXTERN	2003-06-05 21:20:57.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deflate.c	2003-06-05 21:59:09.000000000 +0200
@@ -1255,7 +1255,7 @@
     return flush == Z_FINISH ? finish_done : block_done;
 }
 
-ZEXTERN int ZEXPORT zlib_deflate_workspacesize ()
+extern int ZEXPORT zlib_deflate_workspacesize ()
 {
     return sizeof(deflate_workspace);
 }
--- linux-2.5.70-bk9/include/linux/zlib.h~zlib_cleanup_ZEXTERN	2003-06-05 21:30:48.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zlib.h	2003-06-05 22:00:33.000000000 +0200
@@ -162,14 +162,14 @@
 
                         /* basic functions */
 
-ZEXTERN const char * ZEXPORT zlib_zlibVersion OF((void));
+extern const char * ZEXPORT zlib_zlibVersion OF((void));
 /* The application can compare zlibVersion and ZLIB_VERSION for consistency.
    If the first character differs, the library code actually used is
    not compatible with the zlib.h header file used by the application.
    This check is automatically made by deflateInit and inflateInit.
  */
 
-ZEXTERN void * __zlib_panic_workspace OF((void));
+extern void * __zlib_panic_workspace OF((void));
 /*
  	BIG FAT WARNING:
  	The only valid user of this function is a panic handler. This will
@@ -181,7 +181,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_deflate_workspacesize OF((void));
+extern int ZEXPORT zlib_deflate_workspacesize OF((void));
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -189,7 +189,7 @@
 */
 
 /* 
-ZEXTERN int ZEXPORT deflateInit OF((z_streamp strm, int level));
+extern int ZEXPORT deflateInit OF((z_streamp strm, int level));
 
      Initializes the internal stream state for compression. The fields
    zalloc, zfree and opaque must be initialized before by the caller.
@@ -211,7 +211,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_deflate OF((z_streamp strm, int flush));
+extern int ZEXPORT zlib_deflate OF((z_streamp strm, int flush));
 /*
     deflate compresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may introduce some
@@ -289,7 +289,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_deflateEnd OF((z_streamp strm));
+extern int ZEXPORT zlib_deflateEnd OF((z_streamp strm));
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -303,7 +303,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_inflate_workspacesize OF((void));
+extern int ZEXPORT zlib_inflate_workspacesize OF((void));
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -311,7 +311,7 @@
 */
 
 /* 
-ZEXTERN int ZEXPORT zlib_inflateInit OF((z_streamp strm));
+extern int ZEXPORT zlib_inflateInit OF((z_streamp strm));
 
      Initializes the internal stream state for decompression. The fields
    next_in, avail_in, and workspace must be initialized before by
@@ -331,7 +331,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_inflate OF((z_streamp strm, int flush));
+extern int ZEXPORT zlib_inflate OF((z_streamp strm, int flush));
 /*
     inflate decompresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may some
@@ -400,7 +400,7 @@
 */
 
 
-ZEXTERN int ZEXPORT zlib_inflateEnd OF((z_streamp strm));
+extern int ZEXPORT zlib_inflateEnd OF((z_streamp strm));
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -418,7 +418,7 @@
 */
 
 /*   
-ZEXTERN int ZEXPORT deflateInit2 OF((z_streamp strm,
+extern int ZEXPORT deflateInit2 OF((z_streamp strm,
                                      int  level,
                                      int  method,
                                      int  windowBits,
@@ -461,7 +461,7 @@
    not perform any compression: this will be done by deflate().
 */
                             
-ZEXTERN int ZEXPORT zlib_deflateSetDictionary OF((z_streamp strm,
+extern int ZEXPORT zlib_deflateSetDictionary OF((z_streamp strm,
 						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
@@ -497,7 +497,7 @@
    perform any compression: this will be done by deflate().
 */
 
-ZEXTERN int ZEXPORT zlib_deflateCopy OF((z_streamp dest,
+extern int ZEXPORT zlib_deflateCopy OF((z_streamp dest,
 					    z_streamp source));
 /*
      Sets the destination stream as a complete copy of the source stream.
@@ -515,7 +515,7 @@
    destination.
 */
 
-ZEXTERN int ZEXPORT zlib_deflateReset OF((z_streamp strm));
+extern int ZEXPORT zlib_deflateReset OF((z_streamp strm));
 /*
      This function is equivalent to deflateEnd followed by deflateInit,
    but does not free and reallocate all the internal compression state.
@@ -526,7 +526,7 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
-ZEXTERN int ZEXPORT zlib_deflateParams OF((z_streamp strm,
+extern int ZEXPORT zlib_deflateParams OF((z_streamp strm,
 					      int level,
 					      int strategy));
 /*
@@ -548,7 +548,7 @@
 */
 
 /*   
-ZEXTERN int ZEXPORT inflateInit2 OF((z_streamp strm,
+extern int ZEXPORT inflateInit2 OF((z_streamp strm,
                                      int  windowBits));
 
      This is another version of inflateInit with an extra parameter. The
@@ -570,7 +570,7 @@
    modified, but next_out and avail_out are unchanged.)
 */
 
-ZEXTERN int ZEXPORT zlib_inflateSetDictionary OF((z_streamp strm,
+extern int ZEXPORT zlib_inflateSetDictionary OF((z_streamp strm,
 						     const Byte *dictionary,
 						     uInt  dictLength));
 /*
@@ -589,7 +589,7 @@
    inflate().
 */
 
-ZEXTERN int ZEXPORT zlib_inflateSync OF((z_streamp strm));
+extern int ZEXPORT zlib_inflateSync OF((z_streamp strm));
 /* 
     Skips invalid compressed data until a full flush point (see above the
   description of deflate with Z_FULL_FLUSH) can be found, or until all
@@ -604,7 +604,7 @@
   until success or end of the input data.
 */
 
-ZEXTERN int ZEXPORT zlib_inflateReset OF((z_streamp strm));
+extern int ZEXPORT zlib_inflateReset OF((z_streamp strm));
 /*
      This function is equivalent to inflateEnd followed by inflateInit,
    but does not free and reallocate all the internal decompression state.
@@ -628,15 +628,15 @@
 /* deflateInit and inflateInit are macros to allow checking the zlib version
  * and the compiler's view of z_stream:
  */
-ZEXTERN int ZEXPORT zlib_deflateInit_ OF((z_streamp strm, int level,
+extern int ZEXPORT zlib_deflateInit_ OF((z_streamp strm, int level,
                                      const char *version, int stream_size));
-ZEXTERN int ZEXPORT zlib_inflateInit_ OF((z_streamp strm,
+extern int ZEXPORT zlib_inflateInit_ OF((z_streamp strm,
                                      const char *version, int stream_size));
-ZEXTERN int ZEXPORT zlib_deflateInit2_ OF((z_streamp strm, int  level, int  method,
+extern int ZEXPORT zlib_deflateInit2_ OF((z_streamp strm, int  level, int  method,
                                       int windowBits, int memLevel,
                                       int strategy, const char *version,
                                       int stream_size));
-ZEXTERN int ZEXPORT zlib_inflateInit2_ OF((z_streamp strm, int  windowBits,
+extern int ZEXPORT zlib_inflateInit2_ OF((z_streamp strm, int  windowBits,
                                       const char *version, int stream_size));
 #define zlib_deflateInit(strm, level) \
         zlib_deflateInit_((strm), (level), ZLIB_VERSION, sizeof(z_stream))
@@ -653,9 +653,9 @@
     struct internal_state {int dummy;}; /* hack for buggy compilers */
 #endif
 
-ZEXTERN const char  * ZEXPORT zlib_zError           OF((int err));
-ZEXTERN int           ZEXPORT zlib_inflateSyncPoint OF((z_streamp z));
-ZEXTERN const uLong * ZEXPORT zlib_get_crc_table    OF((void));
+extern const char  * ZEXPORT zlib_zError           OF((int err));
+extern int           ZEXPORT zlib_inflateSyncPoint OF((z_streamp z));
+extern const uLong * ZEXPORT zlib_get_crc_table    OF((void));
 
 #ifdef __cplusplus
 }
