Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTEFP1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTEFP1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:27:36 -0400
Received: from [217.157.19.70] ([217.157.19.70]:48133 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S263813AbTEFP1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:27:33 -0400
From: Thomas Horsten <thomas@horsten.com>
To: "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Date: Tue, 6 May 2003 16:40:13 +0100
User-Agent: KMail/1.5.1
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030506104956.A29357@infradead.org> <200305061510.04619.thomas@horsten.com> <20030506.060642.84373569.davem@redhat.com>
In-Reply-To: <20030506.060642.84373569.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305061640.13360.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 May 2003 2:06 pm, David S. Miller wrote:

>    So, would you prefer this:
>
> Yes, this looks better.

If this is then generally acceptable, Marcelo, could you please take this and 
disregard my earlier patch? I've tested this by building most of gentoo using 
those headers and it didn't seem to break anything.

Thanks :)

--- linux-2.4.21-rc1-orig/include/asm-i386/types.h	2002-08-03 
01:39:45.000000000 +0100
+++ linux-2.4.21-rc1-ac4/include/asm-i386/types.h	2003-05-06 
15:07:06.000000000 +0100
@@ -17,10 +17,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
-#endif
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes



