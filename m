Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbTCWDSM>; Sat, 22 Mar 2003 22:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbTCWDSM>; Sat, 22 Mar 2003 22:18:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14600 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262272AbTCWDSL>;
	Sat, 22 Mar 2003 22:18:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [Linux-ia64] Announce: modutils 2.4.24 is available 
In-reply-to: Your message of "Sun, 23 Mar 2003 03:23:18 -0000."
             <20030323032318.GD31008@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Mar 2003 14:29:05 +1100
Message-ID: <8755.1048390145@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003 03:23:18 +0000, 
Matthew Wilcox <willy@debian.org> wrote:
>On Sun, Mar 23, 2003 at 02:16:01PM +1100, Keith Owens wrote:
>> This version of modutils is functionally identical to 2.4.23 except for
>> those architectures that have function descriptors, i.e. ia64 and
>> ppc64.
>
>parisc also has function descriptors.  what needs to happen for us?

Index: 24.3/include/util.h
--- 24.3/include/util.h Sun, 23 Mar 2003 13:34:28 +1100 kaos (modutils-2.4/51_util.h 1.4 644)
+++ 24.3(w)/include/util.h Sun, 23 Mar 2003 14:28:36 +1100 kaos (modutils-2.4/51_util.h 1.4 644)
@@ -96,7 +96,7 @@ void gzf_close(int fd);
 #define SYMPREFIX "__insmod_";
 extern const char symprefix[10];	/* Must be sizeof(SYMPREFIX), including nul */
 
-#if defined(ARCH_ia64) || defined(ARCH_ppc64)
+#if defined(ARCH_ia64) || defined(ARCH_ppc64) || defined(ARCH_hppa64)
 #define HAS_FUNCTION_DESCRIPTORS
 #endif
 

