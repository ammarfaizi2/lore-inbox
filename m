Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTFEVEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbTFEVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:03:39 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30701 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265136AbTFEVBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:01:35 -0400
Date: Thu, 5 Jun 2003 23:14:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk9 zlib cleanup #6 OF
Message-ID: <20030605211456.GI22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <20030605200958.GB22439@wohnheim.fh-wedel.de> <20030605201850.GC22439@wohnheim.fh-wedel.de> <20030605203346.GE22439@wohnheim.fh-wedel.de> <20030605204955.GH22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030605204955.GH22439@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This is the last patch to clean up zconf.h, at least for now.  Getting
rid of the remaining typedefs is a bit too much work for me and this
late hour.  It will have to wait for another lazy day.

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c

--- linux-2.5.70-bk9/lib/zlib_deflate/deftree.c~zlib_cleanup_OF	2003-06-05 21:23:40.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deftree.c	2003-06-05 22:51:00.000000000 +0200
@@ -132,25 +132,25 @@
  * Local (static) routines in this file.
  */
 
-local void tr_static_init OF((void));
-local void init_block     OF((deflate_state *s));
-local void pqdownheap     OF((deflate_state *s, ct_data *tree, int k));
-local void gen_bitlen     OF((deflate_state *s, tree_desc *desc));
-local void gen_codes      OF((ct_data *tree, int max_code, ush *bl_count));
-local void build_tree     OF((deflate_state *s, tree_desc *desc));
-local void scan_tree      OF((deflate_state *s, ct_data *tree, int max_code));
-local void send_tree      OF((deflate_state *s, ct_data *tree, int max_code));
-local int  build_bl_tree  OF((deflate_state *s));
-local void send_all_trees OF((deflate_state *s, int lcodes, int dcodes,
-                              int blcodes));
-local void compress_block OF((deflate_state *s, ct_data *ltree,
-                              ct_data *dtree));
-local void set_data_type  OF((deflate_state *s));
-local unsigned bi_reverse OF((unsigned value, int length));
-local void bi_windup      OF((deflate_state *s));
-local void bi_flush       OF((deflate_state *s));
-local void copy_block     OF((deflate_state *s, char *buf, unsigned len,
-                              int header));
+local void tr_static_init (void);
+local void init_block     (deflate_state *s);
+local void pqdownheap     (deflate_state *s, ct_data *tree, int k);
+local void gen_bitlen     (deflate_state *s, tree_desc *desc);
+local void gen_codes      (ct_data *tree, int max_code, ush *bl_count);
+local void build_tree     (deflate_state *s, tree_desc *desc);
+local void scan_tree      (deflate_state *s, ct_data *tree, int max_code);
+local void send_tree      (deflate_state *s, ct_data *tree, int max_code);
+local int  build_bl_tree  (deflate_state *s);
+local void send_all_trees (deflate_state *s, int lcodes, int dcodes,
+                           int blcodes);
+local void compress_block (deflate_state *s, ct_data *ltree,
+                           ct_data *dtree);
+local void set_data_type  (deflate_state *s);
+local unsigned bi_reverse (unsigned value, int length);
+local void bi_windup      (deflate_state *s);
+local void bi_flush       (deflate_state *s);
+local void copy_block     (deflate_state *s, char *buf, unsigned len,
+                           int header);
 
 #ifndef DEBUG_ZLIB
 #  define send_code(s, c, tree) send_bits(s, tree[c].Code, tree[c].Len)
@@ -174,7 +174,7 @@
  * IN assertion: length <= 16 and value fits in length bits.
  */
 #ifdef DEBUG_ZLIB
-local void send_bits      OF((deflate_state *s, int value, int length));
+local void send_bits      (deflate_state *s, int value, int length);
 
 local void send_bits(
 	deflate_state *s,
--- linux-2.5.70-bk9/lib/zlib_deflate/deflate.c~zlib_cleanup_OF	2003-06-05 22:14:09.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/deflate.c	2003-06-05 22:52:09.000000000 +0200
@@ -63,22 +63,22 @@
     finish_done     /* finish done, accept no more input or output */
 } block_state;
 
-typedef block_state (*compress_func) OF((deflate_state *s, int flush));
+typedef block_state (*compress_func) (deflate_state *s, int flush);
 /* Compression function. Returns the block state after the call. */
 
-local void fill_window    OF((deflate_state *s));
-local block_state deflate_stored OF((deflate_state *s, int flush));
-local block_state deflate_fast   OF((deflate_state *s, int flush));
-local block_state deflate_slow   OF((deflate_state *s, int flush));
-local void lm_init        OF((deflate_state *s));
-local void putShortMSB    OF((deflate_state *s, uInt b));
-local void flush_pending  OF((z_streamp strm));
-local int read_buf        OF((z_streamp strm, Byte *buf, unsigned size));
-local uInt longest_match  OF((deflate_state *s, IPos cur_match));
+local void fill_window    (deflate_state *s);
+local block_state deflate_stored (deflate_state *s, int flush);
+local block_state deflate_fast   (deflate_state *s, int flush);
+local block_state deflate_slow   (deflate_state *s, int flush);
+local void lm_init        (deflate_state *s);
+local void putShortMSB    (deflate_state *s, uInt b);
+local void flush_pending  (z_streamp strm);
+local int read_buf        (z_streamp strm, Byte *buf, unsigned size);
+local uInt longest_match  (deflate_state *s, IPos cur_match);
 
 #ifdef DEBUG_ZLIB
-local  void check_match OF((deflate_state *s, IPos start, IPos match,
-                            int length));
+local  void check_match (deflate_state *s, IPos start, IPos match,
+                         int length);
 #endif
 
 /* ===========================================================================
--- linux-2.5.70-bk9/lib/zlib_inflate/infblock.h~zlib_cleanup_OF	2003-06-05 21:34:33.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infblock.h	2003-06-05 22:53:35.000000000 +0200
@@ -14,31 +14,31 @@
 struct inflate_blocks_state;
 typedef struct inflate_blocks_state inflate_blocks_statef;
 
-extern inflate_blocks_statef * zlib_inflate_blocks_new OF((
+extern inflate_blocks_statef * zlib_inflate_blocks_new (
     z_streamp z,
-    check_func c,               /* check function */
-    uInt w));                   /* window size */
+    check_func c,              /* check function */
+    uInt w);                   /* window size */
 
-extern int zlib_inflate_blocks OF((
+extern int zlib_inflate_blocks (
     inflate_blocks_statef *,
     z_streamp ,
-    int));                      /* initial return code */
+    int);                      /* initial return code */
 
-extern void zlib_inflate_blocks_reset OF((
+extern void zlib_inflate_blocks_reset (
     inflate_blocks_statef *,
     z_streamp ,
-    uLong *));                  /* check value on output */
+    uLong *);                  /* check value on output */
 
-extern int zlib_inflate_blocks_free OF((
+extern int zlib_inflate_blocks_free (
     inflate_blocks_statef *,
-    z_streamp));
+    z_streamp);
 
-extern void zlib_inflate_set_dictionary OF((
+extern void zlib_inflate_set_dictionary (
     inflate_blocks_statef *s,
-    const Byte *d,   /* dictionary */
-    uInt  n));       /* dictionary length */
+    const Byte *d,  /* dictionary */
+    uInt  n);       /* dictionary length */
 
-extern int zlib_inflate_blocks_sync_point OF((
-    inflate_blocks_statef *s));
+extern int zlib_inflate_blocks_sync_point (
+    inflate_blocks_statef *s);
 
 #endif /* _INFBLOCK_H */
--- linux-2.5.70-bk9/lib/zlib_deflate/defutil.h~zlib_cleanup_OF	2003-06-05 21:22:04.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_deflate/defutil.h	2003-06-05 22:54:15.000000000 +0200
@@ -264,14 +264,14 @@
  */
 
         /* in trees.c */
-void zlib_tr_init         OF((deflate_state *s));
-int  zlib_tr_tally        OF((deflate_state *s, unsigned dist, unsigned lc));
-ulg  zlib_tr_flush_block  OF((deflate_state *s, char *buf, ulg stored_len,
-			      int eof));
-void zlib_tr_align        OF((deflate_state *s));
-void zlib_tr_stored_block OF((deflate_state *s, char *buf, ulg stored_len,
-			      int eof));
-void zlib_tr_stored_type_only OF((deflate_state *));
+void zlib_tr_init         (deflate_state *s);
+int  zlib_tr_tally        (deflate_state *s, unsigned dist, unsigned lc);
+ulg  zlib_tr_flush_block  (deflate_state *s, char *buf, ulg stored_len,
+			   int eof);
+void zlib_tr_align        (deflate_state *s);
+void zlib_tr_stored_block (deflate_state *s, char *buf, ulg stored_len,
+			   int eof);
+void zlib_tr_stored_type_only (deflate_state *);
 
 
 /* ===========================================================================
--- linux-2.5.70-bk9/include/linux/zlib.h~zlib_cleanup_OF	2003-06-05 22:13:00.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zlib.h	2003-06-05 22:57:17.000000000 +0200
@@ -162,14 +162,14 @@
 
                         /* basic functions */
 
-extern const char * zlib_zlibVersion OF((void));
+extern const char * zlib_zlibVersion (void);
 /* The application can compare zlibVersion and ZLIB_VERSION for consistency.
    If the first character differs, the library code actually used is
    not compatible with the zlib.h header file used by the application.
    This check is automatically made by deflateInit and inflateInit.
  */
 
-extern void * __zlib_panic_workspace OF((void));
+extern void * __zlib_panic_workspace (void);
 /*
  	BIG FAT WARNING:
  	The only valid user of this function is a panic handler. This will
@@ -181,7 +181,7 @@
 */
 
 
-extern int zlib_deflate_workspacesize OF((void));
+extern int zlib_deflate_workspacesize (void);
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -189,7 +189,7 @@
 */
 
 /* 
-extern int deflateInit OF((z_streamp strm, int level));
+extern int deflateInit (z_streamp strm, int level);
 
      Initializes the internal stream state for compression. The fields
    zalloc, zfree and opaque must be initialized before by the caller.
@@ -211,7 +211,7 @@
 */
 
 
-extern int zlib_deflate OF((z_streamp strm, int flush));
+extern int zlib_deflate (z_streamp strm, int flush);
 /*
     deflate compresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may introduce some
@@ -289,7 +289,7 @@
 */
 
 
-extern int zlib_deflateEnd OF((z_streamp strm));
+extern int zlib_deflateEnd (z_streamp strm);
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -303,7 +303,7 @@
 */
 
 
-extern int zlib_inflate_workspacesize OF((void));
+extern int zlib_inflate_workspacesize (void);
 /*
    Returns the number of bytes that needs to be allocated for a per-
    stream workspace.  A pointer to this number of bytes should be
@@ -311,7 +311,7 @@
 */
 
 /* 
-extern int zlib_inflateInit OF((z_streamp strm));
+extern int zlib_inflateInit (z_streamp strm);
 
      Initializes the internal stream state for decompression. The fields
    next_in, avail_in, and workspace must be initialized before by
@@ -331,7 +331,7 @@
 */
 
 
-extern int zlib_inflate OF((z_streamp strm, int flush));
+extern int zlib_inflate (z_streamp strm, int flush);
 /*
     inflate decompresses as much data as possible, and stops when the input
   buffer becomes empty or the output buffer becomes full. It may some
@@ -400,7 +400,7 @@
 */
 
 
-extern int zlib_inflateEnd OF((z_streamp strm));
+extern int zlib_inflateEnd (z_streamp strm);
 /*
      All dynamically allocated data structures for this stream are freed.
    This function discards any unprocessed input and does not flush any
@@ -418,12 +418,12 @@
 */
 
 /*   
-extern int deflateInit2 OF((z_streamp strm,
+extern int deflateInit2 (z_streamp strm,
                                      int  level,
                                      int  method,
                                      int  windowBits,
                                      int  memLevel,
-                                     int  strategy));
+                                     int  strategy);
 
      This is another version of deflateInit with more compression options. The
    fields next_in, zalloc, zfree and opaque must be initialized before by
@@ -461,9 +461,9 @@
    not perform any compression: this will be done by deflate().
 */
                             
-extern int zlib_deflateSetDictionary OF((z_streamp strm,
+extern int zlib_deflateSetDictionary (z_streamp strm,
 						     const Byte *dictionary,
-						     uInt  dictLength));
+						     uInt  dictLength);
 /*
      Initializes the compression dictionary from the given byte sequence
    without producing any compressed output. This function must be called
@@ -497,8 +497,7 @@
    perform any compression: this will be done by deflate().
 */
 
-extern int zlib_deflateCopy OF((z_streamp dest,
-					    z_streamp source));
+extern int zlib_deflateCopy (z_streamp dest, z_streamp source);
 /*
      Sets the destination stream as a complete copy of the source stream.
 
@@ -515,7 +514,7 @@
    destination.
 */
 
-extern int zlib_deflateReset OF((z_streamp strm));
+extern int zlib_deflateReset (z_streamp strm);
 /*
      This function is equivalent to deflateEnd followed by deflateInit,
    but does not free and reallocate all the internal compression state.
@@ -526,9 +525,7 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
-extern int zlib_deflateParams OF((z_streamp strm,
-					      int level,
-					      int strategy));
+extern int zlib_deflateParams (z_streamp strm, int level, int strategy);
 /*
      Dynamically update the compression level and compression strategy.  The
    interpretation of level and strategy is as in deflateInit2.  This can be
@@ -548,8 +545,7 @@
 */
 
 /*   
-extern int inflateInit2 OF((z_streamp strm,
-                                     int  windowBits));
+extern int inflateInit2 (z_streamp strm, int  windowBits);
 
      This is another version of inflateInit with an extra parameter. The
    fields next_in, avail_in, zalloc, zfree and opaque must be initialized
@@ -570,9 +566,9 @@
    modified, but next_out and avail_out are unchanged.)
 */
 
-extern int zlib_inflateSetDictionary OF((z_streamp strm,
+extern int zlib_inflateSetDictionary (z_streamp strm,
 						     const Byte *dictionary,
-						     uInt  dictLength));
+						     uInt  dictLength);
 /*
      Initializes the decompression dictionary from the given uncompressed byte
    sequence. This function must be called immediately after a call of inflate
@@ -589,7 +585,7 @@
    inflate().
 */
 
-extern int zlib_inflateSync OF((z_streamp strm));
+extern int zlib_inflateSync (z_streamp strm);
 /* 
     Skips invalid compressed data until a full flush point (see above the
   description of deflate with Z_FULL_FLUSH) can be found, or until all
@@ -604,7 +600,7 @@
   until success or end of the input data.
 */
 
-extern int zlib_inflateReset OF((z_streamp strm));
+extern int zlib_inflateReset (z_streamp strm);
 /*
      This function is equivalent to inflateEnd followed by inflateInit,
    but does not free and reallocate all the internal decompression state.
@@ -614,7 +610,7 @@
    stream state was inconsistent (such as zalloc or state being NULL).
 */
 
-extern int zlib_inflateIncomp OF((z_stream *strm));
+extern int zlib_inflateIncomp (z_stream *strm);
 /*
      This function adds the data at next_in (avail_in bytes) to the output
    history without performing any output.  There must be no pending output,
@@ -628,16 +624,16 @@
 /* deflateInit and inflateInit are macros to allow checking the zlib version
  * and the compiler's view of z_stream:
  */
-extern int zlib_deflateInit_ OF((z_streamp strm, int level,
-                                     const char *version, int stream_size));
-extern int zlib_inflateInit_ OF((z_streamp strm,
-                                     const char *version, int stream_size));
-extern int zlib_deflateInit2_ OF((z_streamp strm, int  level, int  method,
+extern int zlib_deflateInit_ (z_streamp strm, int level,
+                                     const char *version, int stream_size);
+extern int zlib_inflateInit_ (z_streamp strm,
+                                     const char *version, int stream_size);
+extern int zlib_deflateInit2_ (z_streamp strm, int  level, int  method,
                                       int windowBits, int memLevel,
                                       int strategy, const char *version,
-                                      int stream_size));
-extern int zlib_inflateInit2_ OF((z_streamp strm, int  windowBits,
-                                      const char *version, int stream_size));
+                                      int stream_size);
+extern int zlib_inflateInit2_ (z_streamp strm, int  windowBits,
+                                      const char *version, int stream_size);
 #define zlib_deflateInit(strm, level) \
         zlib_deflateInit_((strm), (level), ZLIB_VERSION, sizeof(z_stream))
 #define zlib_inflateInit(strm) \
@@ -653,9 +649,9 @@
     struct internal_state {int dummy;}; /* hack for buggy compilers */
 #endif
 
-extern const char  * zlib_zError           OF((int err));
-extern int           zlib_inflateSyncPoint OF((z_streamp z));
-extern const uLong * zlib_get_crc_table    OF((void));
+extern const char  * zlib_zError           (int err);
+extern int           zlib_inflateSyncPoint (z_streamp z);
+extern const uLong * zlib_get_crc_table    (void);
 
 #ifdef __cplusplus
 }
--- linux-2.5.70-bk9/lib/zlib_inflate/infcodes.h~zlib_cleanup_OF	2003-06-05 21:34:12.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infcodes.h	2003-06-05 22:57:48.000000000 +0200
@@ -16,18 +16,18 @@
 struct inflate_codes_state;
 typedef struct inflate_codes_state inflate_codes_statef;
 
-extern inflate_codes_statef *zlib_inflate_codes_new OF((
+extern inflate_codes_statef *zlib_inflate_codes_new (
     uInt, uInt,
     inflate_huft *, inflate_huft *,
-    z_streamp ));
+    z_streamp );
 
-extern int zlib_inflate_codes OF((
+extern int zlib_inflate_codes (
     inflate_blocks_statef *,
     z_streamp ,
-    int));
+    int);
 
-extern void zlib_inflate_codes_free OF((
+extern void zlib_inflate_codes_free (
     inflate_codes_statef *,
-    z_streamp ));
+    z_streamp );
 
 #endif /* _INFCODES_H */
--- linux-2.5.70-bk9/lib/zlib_inflate/inftrees.h~zlib_cleanup_OF	2003-06-05 21:34:42.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inftrees.h	2003-06-05 22:58:38.000000000 +0200
@@ -35,14 +35,14 @@
    value below is more than safe. */
 #define MANY 1440
 
-extern int zlib_inflate_trees_bits OF((
+extern int zlib_inflate_trees_bits (
     uInt *,                     /* 19 code lengths */
     uInt *,                     /* bits tree desired/actual depth */
     inflate_huft **,            /* bits tree result */
     inflate_huft *,             /* space for trees */
-    z_streamp));                /* for messages */
+    z_streamp);                 /* for messages */
 
-extern int zlib_inflate_trees_dynamic OF((
+extern int zlib_inflate_trees_dynamic (
     uInt,                       /* number of literal/length codes */
     uInt,                       /* number of distance codes */
     uInt *,                     /* that many (total) code lengths */
@@ -51,13 +51,13 @@
     inflate_huft **,            /* literal/length tree result */
     inflate_huft **,            /* distance tree result */
     inflate_huft *,             /* space for trees */
-    z_streamp));                /* for messages */
+    z_streamp);                 /* for messages */
 
-extern int zlib_inflate_trees_fixed OF((
+extern int zlib_inflate_trees_fixed (
     uInt *,                     /* literal desired/actual bit depth */
     uInt *,                     /* distance desired/actual bit depth */
     inflate_huft **,            /* literal/length tree result */
     inflate_huft **,            /* distance tree result */
-    z_streamp));                /* for memory allocation */
+    z_streamp);                 /* for memory allocation */
 
 #endif /* _INFTREES_H */
--- linux-2.5.70-bk9/lib/zlib_inflate/inftrees.c~zlib_cleanup_OF	2003-06-05 21:26:36.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inftrees.c	2003-06-05 22:59:09.000000000 +0200
@@ -22,7 +22,7 @@
 #define bits word.what.Bits
 
 
-local int huft_build OF((
+local int huft_build (
     uInt *,             /* code lengths in bits */
     uInt,               /* number of codes */
     uInt,               /* number of "simple" codes */
@@ -32,7 +32,7 @@
     uInt *,             /* maximum lookup bits (returns actual) */
     inflate_huft *,     /* space for trees */
     uInt *,             /* hufts used in space */
-    uInt * ));          /* space for values */
+    uInt * );           /* space for values */
 
 /* Tables for deflate from PKZIP's appnote.txt. */
 local const uInt cplens[31] = { /* Copy lengths for literal codes 257..285 */
--- linux-2.5.70-bk9/lib/zlib_inflate/infutil.h~zlib_cleanup_OF	2003-06-05 21:27:33.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/infutil.h	2003-06-05 22:59:45.000000000 +0200
@@ -92,10 +92,10 @@
 extern uInt zlib_inflate_mask[17];
 
 /* copy as much as possible from the sliding window to the output area */
-extern int zlib_inflate_flush OF((
+extern int zlib_inflate_flush (
     inflate_blocks_statef *,
     z_streamp ,
-    int));
+    int);
 
 /* inflate private state */
 typedef enum {
--- linux-2.5.70-bk9/lib/zlib_inflate/inffast.h~zlib_cleanup_OF	2003-04-07 19:30:43.000000000 +0200
+++ linux-2.5.70-bk9/lib/zlib_inflate/inffast.h	2003-06-05 23:00:05.000000000 +0200
@@ -8,10 +8,10 @@
    subject to change. Applications should only use zlib.h.
  */
 
-extern int zlib_inflate_fast OF((
+extern int zlib_inflate_fast (
     uInt,
     uInt,
     inflate_huft *,
     inflate_huft *,
     inflate_blocks_statef *,
-    z_streamp ));
+    z_streamp );
--- linux-2.5.70-bk9/include/linux/zutil.h~zlib_cleanup_OF	2003-06-05 22:13:00.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zutil.h	2003-06-05 23:01:00.000000000 +0200
@@ -62,8 +62,8 @@
 
          /* functions */
 
-typedef uLong (*check_func) OF((uLong check, const Byte *buf,
-				       uInt len));
+typedef uLong (*check_func) (uLong check, const Byte *buf,
+				       uInt len);
 
 
                         /* checksum functions */
--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_OF	2003-06-05 22:42:41.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 23:02:44.000000000 +0200
@@ -37,14 +37,9 @@
 
                         /* Type declarations */
 
-#    define OF(args)  args
-
 typedef unsigned char  Byte;  /* 8 bits */
 typedef unsigned int   uInt;  /* 16 bits or more */
 typedef unsigned long  uLong; /* 32 bits or more */
 typedef void     *voidp;
 
-#include <linux/types.h> /* for off_t */
-#include <linux/unistd.h>    /* for SEEK_* and off_t */
-
 #endif /* _ZCONF_H */
