Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137116AbREKMM2>; Fri, 11 May 2001 08:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137120AbREKMMR>; Fri, 11 May 2001 08:12:17 -0400
Received: from srvr1.telecom.lt ([212.59.0.10]:64518 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S137116AbREKML7>;
	Fri, 11 May 2001 08:11:59 -0400
Message-Id: <200105111211.OAA2463820@mail.takas.lt>
Date: Fri, 11 May 2001 14:10:31 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: [PATCH] (updated) for iso8859-13
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrzej Krzysztofowicz <ankry@pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.62 'Mars', compiled for Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001 08:24:46 +0200 Andrzej Krzysztofowicz <ankry@pg.gda.pl> wrote:

> "Nerijus Baliunas wrote:"
> > -NLS ISO 8859-1  (Latin 1; Western European Languages)
> > +NLS ISO 8859-1 (Latin 1; Western European Languages)
> 
> Should'n it be consistent with Config.in ?

Probably. Updated patch:

--- Configure.help        Fri May 11 01:52:15 2001
+++ Configure.help.new        Fri May 11 14:03:45 2001
@@ -12567,8 +12567,8 @@
   cp862, cp863, cp864, cp865, cp866, cp869, cp874, cp932, cp936,
   cp949, cp950, cp1251, cp1255, euc-jp, euc-kr, gb2312, iso8859-1,
   iso8859-2, iso8859-3, iso8859-4, iso8859-5, iso8859-6, iso8859-7,
-  iso8859-8, iso8859-9, iso8859-14, iso8859-15, koi8-r, koi8-ru,
-  koi8-u, sjis, tis-620, utf8.
+  iso8859-8, iso8859-9, iso8859-13, iso8859-14, iso8859-15,
+  koi8-r, koi8-ru, koi8-u, sjis, tis-620, utf8.
   If you specify a wrong value, it will use the built-in NLS;
   compatible with iso8859-1.
 
@@ -12605,7 +12605,8 @@
   DOS/Windows partitions correctly. This does apply to the filenames
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage that is used
-  for the Baltic Rim Languages. If unsure, say N.
+  for the Baltic Rim Languages (Latvian and Lithuanian). If unsure,
+  say N.
 
 Codepage 850 (Europe)
 CONFIG_NLS_CODEPAGE_850
@@ -12841,7 +12842,7 @@
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the Latin 4 character
   set which introduces letters for Estonian, Latvian, and
-  Lithuanian. It is an incomplete predecessor of Latin 6.
+  Lithuanian. It is an incomplete predecessor of Latin 7.
 
 NLS ISO 8859-5  (Cyrillic)
 CONFIG_NLS_ISO8859_5
@@ -12886,7 +12887,7 @@
   set, and it replaces the rarely needed Icelandic letters in Latin 1
   with the Turkish ones. Useful in Turkey.
 
-nls iso8859-10
+NLS ISO 8859-10 (Latin 6; Nordic)
 CONFIG_NLS_ISO8859_10
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12902,7 +12903,8 @@
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the Latin 7 character
-  set, which supports modern Baltic languages including Latvian.
+  set, which supports modern Baltic languages including Latvian
+  and Lithuanian.
 
 NLS ISO 8859-14 (Latin 8; Celtic)
 CONFIG_NLS_ISO8859_14
@@ -12926,8 +12928,8 @@
   Portuguese, Spanish, and Swedish. Latin 9 is an update to
   Latin 1 (ISO 8859-1) that removes a handful of rarely used
   characters and instead adds support for Estonian, corrects the
-  support for French and Finnish, and adds the new Euro character.  If
-  unsure, say Y.
+  support for French and Finnish, and adds the new Euro character.
+  If unsure, say Y.
 
 NLS KOI8-R (Russian) 
 CONFIG_NLS_KOI8_R


