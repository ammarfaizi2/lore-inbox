Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbREQQdX>; Thu, 17 May 2001 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbREQQdN>; Thu, 17 May 2001 12:33:13 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:61655 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262026AbREQQdE>; Thu, 17 May 2001 12:33:04 -0400
Message-ID: <3B03F9F9.FA032E4B@TeraPort.de>
Date: Thu, 17 May 2001 18:19:05 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig - cosmetic question
In-Reply-To: <Pine.LNX.3.96.1010517151441.14658A-100000@medusa.sparta.lu.se> <3B03EE1E.5A050E1B@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin.Knoblauch" wrote:
> 
> 
>  Not sure whether this is worth to put into the next release - maybe
> someone can spend two minutes to crosscheck.
> 

 This looks more complete. 

lx/linux > diff -u scripts/Menuconfig.orig scripts/Menuconfig
--- scripts/Menuconfig.orig     Thu May 17 17:19:21 2001
+++ scripts/Menuconfig  Thu May 17 18:10:22 2001
@@ -74,7 +74,10 @@
 # - Implemented new functions: define_tristate(), define_int(),
define_hex(),
 #   define_string(), dep_bool().
 #
-
+# 17 May 2001, Martin Knoblauch, <knobi@knobisoft.de>
+# - Fix output of comment strings to .config/autoconfig.h so that they
equal
+#   the comments from "make [old]config"
+#

 #
 # Change this to TRUE if you prefer all kernel options listed
@@ -1240,7 +1243,7 @@
        }
 
        function mainmenu_option () {
-               comment_is_option=TRUE
+               :
        }
 
        function endmenu () {
@@ -1248,9 +1251,7 @@
        }
 
        function comment () {
-               if [ "$comment_is_option" ]
-               then
-                       comment_is_option=
+
                        echo        >>$CONFIG
                        echo "#"    >>$CONFIG
                        echo "# $1" >>$CONFIG
@@ -1260,7 +1261,6 @@
                        echo "/*"    >>$CONFIG_H
                        echo " * $1" >>$CONFIG_H
                        echo " */"   >>$CONFIG_H
-               fi
        }
 
        echo -n "."

Martin
PS: This time without vcard ...
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
