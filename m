Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUBQR3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUBQR3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:29:51 -0500
Received: from mail.timesys.com ([65.117.135.102]:3411 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266292AbUBQR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:29:49 -0500
Message-ID: <40324F78.3000108@timesys.com>
Date: Tue, 17 Feb 2004 12:29:28 -0500
From: Pratik Solanki <pratik.solanki@timesys.com>
Organization: TimeSys Corporation
User-Agent: Mozilla Thunderbird 0.5 (X11/20040213)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor cross-compile issues
References: <4027B7D3.2020107@timesys.com> <20040216205800.GC2977@mars.ravnborg.org> <403242DF.7030204@timesys.com> <20040217170042.GC2178@mars.ravnborg.org>
In-Reply-To: <20040217170042.GC2178@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------090605020507020908040505"
X-OriginalArrivalTime: 17 Feb 2004 17:22:56.0250 (UTC) FILETIME=[AEB63DA0:01C3F57A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090605020507020908040505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Based on Sam's suggestion, here's the updated patch.

Pratik.

On 02/17/2004 12:00 PM, Sam Ravnborg wrote:

>On Tue, Feb 17, 2004 at 11:35:43AM -0500, Pratik Solanki wrote:
>  
>
>>Thanks Sam. Would you be checking in your proposed change or should I 
>>send a new patch?
>>    
>>
>
>Please send an updated patch to Andrew Morton.
>
>	Sam
>  
>

--------------090605020507020908040505
Content-Type: text/plain;
 name="asm-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm-boot.patch"

===== arch/i386/boot/Makefile 1.28 vs edited =====
--- 1.28/arch/i386/boot/Makefile	Thu Sep 11 06:01:23 2003
+++ edited/arch/i386/boot/Makefile	Tue Feb 17 11:56:45 2004
@@ -31,6 +31,8 @@
 
 host-progs	:= tools/build
 
+HOSTCFLAGS_build.o := -Iinclude
+
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000

--------------090605020507020908040505--
