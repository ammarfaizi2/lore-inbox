Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTEGFkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTEGFkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:40:16 -0400
Received: from [62.29.80.31] ([62.29.80.31]:14468 "EHLO cmpe.boun.edu.tr")
	by vger.kernel.org with ESMTP id S262873AbTEGFkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:40:14 -0400
From: "ismail (cartman) donmez" <voidcartman@yahoo.com>
Organization: Bogazici University
To: Thomas Horsten <thomas@horsten.com>, "David S. Miller" <davem@redhat.com>,
       marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Date: Wed, 7 May 2003 08:50:59 +0300
User-Agent: KMail/1.5.9
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030506104956.A29357@infradead.org> <20030506.060642.84373569.davem@redhat.com> <200305061640.13360.thomas@horsten.com>
In-Reply-To: <200305061640.13360.thomas@horsten.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305070850.59912.voidcartman@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 May 2003 18:40, Thomas Horsten wrote:
> --- linux-2.4.21-rc1-orig/include/asm-i386/types.h	2002-08-03
> 01:39:45.000000000 +0100
> +++ linux-2.4.21-rc1-ac4/include/asm-i386/types.h	2003-05-06
> 15:07:06.000000000 +0100
> @@ -17,10 +17,8 @@
>  typedef __signed__ int __s32;
>  typedef unsigned int __u32;
>
> -#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
>  typedef __signed__ long long __s64;
>  typedef unsigned long long __u64;
> -#endif

Imho this is bad here you define a long long variable even if userspace apps 
use -ansi flag where Ansi standart has no support for long long variables. I 
think this should be fixed in userspace.

-- 
Brain fried -- Core dumped 
