Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbTAKFGZ>; Sat, 11 Jan 2003 00:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTAKFFX>; Sat, 11 Jan 2003 00:05:23 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:7578 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id <S267174AbTAKFEm>;
	Sat, 11 Jan 2003 00:04:42 -0500
Message-ID: <3E1FA9C8.3010509@cox.net>
Date: Fri, 10 Jan 2003 22:21:12 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation error for kconfig
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless I'm not thinking clearly, the attached patch for 
Documentation/kbuild/kconfig-language.txt is in order. The min/max 
equivalences for the || and && operators are backwards...

(Apologies if Mozilla munges the patch... it's small enough to be easily 
recreatable anyway).

diff -X dontdiff -rN -U 15 
linux-2.5/Documentation/kbuild/kconfig-language.txt 
linux-2.5-new/Documentation/kbuild/kconfig-language.txt
--- linux-2.5/Documentation/kbuild/kconfig-language.txt	Wed Jan  1 
20:21:41 2003
+++ linux-2.5-new/Documentation/kbuild/kconfig-language.txt	Fri Jan 10 
22:08:23 2003
@@ -111,32 +111,32 @@
             '!' <expr>                           (5)
             <expr> '||' <expr>                   (6)
             <expr> '&&' <expr>                   (7)

  Expressions are listed in decreasing order of precedence.

  (1) Convert the symbol into an expression. Boolean and tristate symbols
      are simply converted into the respective expression values. All
      other symbol types result in 'n'.
  (2) If the values of both symbols are equal, it returns 'y',
      otherwise 'n'.
  (3) If the values of both symbols are equal, it returns 'n',
      otherwise 'y'.
  (4) Returns the value of the expression. Used to override precedence.
  (5) Returns the result of (2-/expr/).
-(6) Returns the result of min(/expr/, /expr/).
-(7) Returns the result of max(/expr/, /expr/).
+(6) Returns the result of max(/expr/, /expr/).
+(7) Returns the result of min(/expr/, /expr/).

  An expression can have a value of 'n', 'm' or 'y' (or 0, 1, 2
  respectively for calculations). A menu entry becomes visible when it's
  expression evaluates to 'm' or 'y'.

  There are two type of symbols: constant and nonconstant symbols.
  Nonconstant symbols are the most common ones and are defined with the
  'config' statement. Nonconstant symbols consist entirely of alphanumeric
  characters or underscores.
  Constant symbols are only part of expressions. Constant symbols are
  always surrounded by single or double quotes. Within the quote any
  other character is allowed and the quotes can be escaped using '\'.

  Menu structure
  --------------

