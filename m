Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTCWDam>; Sat, 22 Mar 2003 22:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCWDam>; Sat, 22 Mar 2003 22:30:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29192 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262258AbTCWDal>;
	Sat, 22 Mar 2003 22:30:41 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: willy@debian.org, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: [Linux-ia64] Announce: modutils 2.4.24 is available 
In-reply-to: Your message of "Sat, 22 Mar 2003 22:37:43 CDT."
             <200303230337.h2N3bhAC026836@hiauly1.hia.nrc.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Mar 2003 14:41:33 +1100
Message-ID: <8942.1048390893@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003 22:37:43 -0500 (EST), 
"John David Anglin" <dave@hiauly1.hia.nrc.ca> wrote:
>> -#if defined(ARCH_ia64) || defined(ARCH_ppc64)
>> +#if defined(ARCH_ia64) || defined(ARCH_ppc64) || defined(ARCH_hppa64)
>>  #define HAS_FUNCTION_DESCRIPTORS
>>  #endif
>
>The 32-bit hppa port also has function descriptors.

They keep coming out of the woodwork :(  Any more architectures using
function descriptors?  Just add them to the list below.

Index: 24.3/include/util.h
--- 24.3/include/util.h Sun, 23 Mar 2003 13:34:28 +1100 kaos (modutils-2.4/51_util.h 1.4 644)
+++ 24.3(w)/include/util.h Sun, 23 Mar 2003 14:40:06 +1100 kaos (modutils-2.4/51_util.h 1.4 644)
@@ -96,7 +96,7 @@ void gzf_close(int fd);
 #define SYMPREFIX "__insmod_";
 extern const char symprefix[10];	/* Must be sizeof(SYMPREFIX), including nul */
 
-#if defined(ARCH_ia64) || defined(ARCH_ppc64)
+#if defined(ARCH_ia64) || defined(ARCH_ppc64) || defined(ARCH_hppa) || defined(ARCH_hppa64)
 #define HAS_FUNCTION_DESCRIPTORS
 #endif
 

