Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUJRWla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUJRWla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUJRWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:41:30 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:219 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S267649AbUJRWl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:41:26 -0400
Message-ID: <41744695.4020406@verizon.net>
Date: Mon, 18 Oct 2004 18:41:25 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More patches to arch/sparc/Kconfig [2 of 5]
References: <41738FD4.5020008@verizon.net> <20041018102738.GF5607@holomorphy.com>
In-Reply-To: <20041018102738.GF5607@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------060505080404070304010802"
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 17:41:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060505080404070304010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> On Mon, Oct 18, 2004 at 05:41:40AM -0400, Jim Nelson wrote:
> 
>>Fixes typo in help in openpromfs.
>>Apply against 2.6.9-rc4.
>>diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig
>>--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
>>+++ ./arch/sparc/Kconfig	2004-10-16 10:13:17.660148269 -0400
>>@@ -248,7 +248,7 @@
>> 	  -t openpromfs none /proc/openprom".
>> 
>> 	  To compile the /proc/openprom support as a module, choose M here: the
>>-	  module will be called openpromfs.  If unsure, choose M.
>>+	  module will be called openpromfs.  If unsure, choose N.
>> 
>> source "fs/Kconfig.binfmt"
> 
> 
> Except this one. I'm relatively sure this is not a typo.
> 
> 
> -- wli
> 

You may be right about openpromfs.  How's this instead:

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig





--------------060505080404070304010802
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-openpromfs-help-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-openpromfs-help-2.patch"

--- arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ arch/sparc/Kconfig	2004-10-18 18:38:05.125374024 -0400
@@ -248,7 +248,10 @@
 	  -t openpromfs none /proc/openprom".
 
 	  To compile the /proc/openprom support as a module, choose M here: the
-	  module will be called openpromfs.  If unsure, choose M.
+	  module will be called openpromfs.
+
+	  Only choose N if you know in advance that you will not need to modify
+	  OpenPROM settings on the running system.
 
 source "fs/Kconfig.binfmt"
 

--------------060505080404070304010802--
