Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVLUBuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVLUBuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLUBuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:50:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18635 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932247AbVLUBuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:50:00 -0500
Date: Tue, 20 Dec 2005 19:49:57 -0600
From: Robin Holt <holt@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch 3/5] Rebuild scripts/genksyms/lex.c_shipped following parse.y change.
Message-ID: <20051221014957.GD2784@lnx-holt.americas.sgi.com>
References: <20051221014550.GA2784@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221014550.GA2784@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/genksyms/lex.c_shipped regenerated following parse.y change.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/scripts/genksyms/lex.c_shipped
===================================================================
--- linux-2.6.orig/scripts/genksyms/lex.c_shipped	2005-12-20 19:18:51.405780501 -0600
+++ linux-2.6/scripts/genksyms/lex.c_shipped	2005-12-20 19:19:31.841281012 -0600
@@ -10,7 +10,6 @@
 #define YY_FLEX_MINOR_VERSION 5
 
 #include <stdio.h>
-#include <unistd.h>
 
 
 /* cfront 1.2 defines "c_plusplus" instead of "__cplusplus" */
@@ -24,6 +23,7 @@
 #ifdef __cplusplus
 
 #include <stdlib.h>
+#include <unistd.h>
 
 /* Use prototypes in function declarations. */
 #define YY_USE_PROTOS
@@ -660,7 +660,7 @@ YY_MALLOC_DECL
 YY_DECL
 	{
 	register yy_state_type yy_current_state;
-	register char *yy_cp = NULL, *yy_bp = NULL;
+	register char *yy_cp, *yy_bp;
 	register int yy_act;
 
 #line 65 "scripts/genksyms/lex.l"
@@ -1405,6 +1405,11 @@ YY_BUFFER_STATE b;
 	}
 
 
+#ifndef YY_ALWAYS_INTERACTIVE
+#ifndef YY_NEVER_INTERACTIVE
+extern int isatty YY_PROTO(( int ));
+#endif
+#endif
 
 #ifdef YY_USE_PROTOS
 void yy_init_buffer( YY_BUFFER_STATE b, FILE *file )
@@ -2036,49 +2041,131 @@ fini:
 
   return token;
 }
-#ifndef YYSTYPE
-#define YYSTYPE int
-#endif
-#define	ASM_KEYW	257
-#define	ATTRIBUTE_KEYW	258
-#define	AUTO_KEYW	259
-#define	BOOL_KEYW	260
-#define	CHAR_KEYW	261
-#define	CONST_KEYW	262
-#define	DOUBLE_KEYW	263
-#define	ENUM_KEYW	264
-#define	EXTERN_KEYW	265
-#define	FLOAT_KEYW	266
-#define	INLINE_KEYW	267
-#define	INT_KEYW	268
-#define	LONG_KEYW	269
-#define	REGISTER_KEYW	270
-#define	RESTRICT_KEYW	271
-#define	SHORT_KEYW	272
-#define	SIGNED_KEYW	273
-#define	STATIC_KEYW	274
-#define	STRUCT_KEYW	275
-#define	TYPEDEF_KEYW	276
-#define	UNION_KEYW	277
-#define	UNSIGNED_KEYW	278
-#define	VOID_KEYW	279
-#define	VOLATILE_KEYW	280
-#define	TYPEOF_KEYW	281
-#define	EXPORT_SYMBOL_KEYW	282
-#define	ASM_PHRASE	283
-#define	ATTRIBUTE_PHRASE	284
-#define	BRACE_PHRASE	285
-#define	BRACKET_PHRASE	286
-#define	EXPRESSION_PHRASE	287
-#define	CHAR	288
-#define	DOTS	289
-#define	IDENT	290
-#define	INT	291
-#define	REAL	292
-#define	STRING	293
-#define	TYPE	294
-#define	OTHER	295
-#define	FILENAME	296
+/* A Bison parser, made by GNU Bison 1.875.  */
+
+/* Skeleton parser for Yacc-like parsing with Bison,
+   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002 Free Software Foundation, Inc.
 
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+/* As a special exception, when this file is copied by Bison into a
+   Bison output file, you may use that output file without restriction.
+   This special exception was added by the Free Software Foundation
+   in version 1.24 of Bison.  */
+
+/* Tokens.  */
+#ifndef YYTOKENTYPE
+# define YYTOKENTYPE
+   /* Put the tokens into the symbol table, so that GDB and other debuggers
+      know about them.  */
+   enum yytokentype {
+     ASM_KEYW = 258,
+     ATTRIBUTE_KEYW = 259,
+     AUTO_KEYW = 260,
+     BOOL_KEYW = 261,
+     CHAR_KEYW = 262,
+     CONST_KEYW = 263,
+     DOUBLE_KEYW = 264,
+     ENUM_KEYW = 265,
+     EXTERN_KEYW = 266,
+     FLOAT_KEYW = 267,
+     INLINE_KEYW = 268,
+     INT_KEYW = 269,
+     LONG_KEYW = 270,
+     REGISTER_KEYW = 271,
+     RESTRICT_KEYW = 272,
+     SHORT_KEYW = 273,
+     SIGNED_KEYW = 274,
+     STATIC_KEYW = 275,
+     STRUCT_KEYW = 276,
+     TYPEDEF_KEYW = 277,
+     UNION_KEYW = 278,
+     UNSIGNED_KEYW = 279,
+     VOID_KEYW = 280,
+     VOLATILE_KEYW = 281,
+     TYPEOF_KEYW = 282,
+     EXPORT_SYMBOL_KEYW = 283,
+     ASM_PHRASE = 284,
+     ATTRIBUTE_PHRASE = 285,
+     BRACE_PHRASE = 286,
+     BRACKET_PHRASE = 287,
+     EXPRESSION_PHRASE = 288,
+     CHAR = 289,
+     DOTS = 290,
+     IDENT = 291,
+     INT = 292,
+     REAL = 293,
+     STRING = 294,
+     TYPE = 295,
+     OTHER = 296,
+     FILENAME = 297
+   };
+#endif
+#define ASM_KEYW 258
+#define ATTRIBUTE_KEYW 259
+#define AUTO_KEYW 260
+#define BOOL_KEYW 261
+#define CHAR_KEYW 262
+#define CONST_KEYW 263
+#define DOUBLE_KEYW 264
+#define ENUM_KEYW 265
+#define EXTERN_KEYW 266
+#define FLOAT_KEYW 267
+#define INLINE_KEYW 268
+#define INT_KEYW 269
+#define LONG_KEYW 270
+#define REGISTER_KEYW 271
+#define RESTRICT_KEYW 272
+#define SHORT_KEYW 273
+#define SIGNED_KEYW 274
+#define STATIC_KEYW 275
+#define STRUCT_KEYW 276
+#define TYPEDEF_KEYW 277
+#define UNION_KEYW 278
+#define UNSIGNED_KEYW 279
+#define VOID_KEYW 280
+#define VOLATILE_KEYW 281
+#define TYPEOF_KEYW 282
+#define EXPORT_SYMBOL_KEYW 283
+#define ASM_PHRASE 284
+#define ATTRIBUTE_PHRASE 285
+#define BRACE_PHRASE 286
+#define BRACKET_PHRASE 287
+#define EXPRESSION_PHRASE 288
+#define CHAR 289
+#define DOTS 290
+#define IDENT 291
+#define INT 292
+#define REAL 293
+#define STRING 294
+#define TYPE 295
+#define OTHER 296
+#define FILENAME 297
+
+
+
+
+#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
+typedef int YYSTYPE;
+# define yystype YYSTYPE /* obsolescent; will be withdrawn */
+# define YYSTYPE_IS_DECLARED 1
+# define YYSTYPE_IS_TRIVIAL 1
+#endif
 
 extern YYSTYPE yylval;
+
+
+
