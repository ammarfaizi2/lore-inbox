Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTAGSBN>; Tue, 7 Jan 2003 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTAGSBN>; Tue, 7 Jan 2003 13:01:13 -0500
Received: from zeke.inet.com ([199.171.211.198]:995 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267540AbTAGSBJ>;
	Tue, 7 Jan 2003 13:01:09 -0500
Message-ID: <3E1B17E8.9080203@inet.com>
Date: Tue, 07 Jan 2003 12:09:44 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Re: [RFC] Documentation/kbuild/makefiles.txt
References: <20030105215137.GA3659@mars.ravnborg.org> <Pine.LNX.4.33L2.0301051619210.13623-100000@dragon.pdx.osdl.net> <20030106193651.GA1320@mars.ravnborg.org> <20030107165624.GA1222@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------000602050508020708080708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000602050508020708080708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:
> Third version with input from Randy incorporated - thanks!
> Also added LDFLAGS_MODULE
> 
> 	Sam
> 
> Linux Kernel Makefiles
> 
> This document describes the Linux kernel Makefiles.

This looks like an extremely useful document.  A few suggestions attached.

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

--------------000602050508020708080708
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- makefiledoc.txt.orig	Tue Jan  7 11:43:23 2003
+++ makefiledoc.txt	Tue Jan  7 12:05:13 2003
@@ -438,7 +438,7 @@
 
 --- 4.3 Defining shared libraries  
   
-	Objects with extension .so is considered shared libraries, and will
+	Objects with extension .so are considered shared libraries, and will
 	be compiled as position independent objects.
 	Kbuild provides support for shared libraries, but the usage
 	shall be restricted.
@@ -514,7 +514,7 @@
 	as a prerequisite.
 	This is possible in two ways:
 
-	(1) List the prerequisite explicit in a special rule.
+	(1) List the prerequisite explicitly in a special rule.
 
 	Example:
 		#drivers/pci/Makefile
@@ -522,7 +522,7 @@
 		$(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
 			( cd $(obj); ./gen-devlist ) < $<
 
-	The target $(obj)/devlist.h will not be build before 
+	The target $(obj)/devlist.h will not be built before 
 	$(obj)/gen-devlist is updated. Note that references to
 	the host programs in special rules must be prefixed with $(obj).
 

--------------000602050508020708080708--

