Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287267AbSABNJE>; Wed, 2 Jan 2002 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287454AbSABNIp>; Wed, 2 Jan 2002 08:08:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36871 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287267AbSABNIm>;
	Wed, 2 Jan 2002 08:08:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: ollie@sis.com.tw, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18-pre1 sound/trident fix with newer binutils 
In-Reply-To: Your message of "Wed, 02 Jan 2002 07:46:12 CDT."
             <3C330114.D4F66B45@bellsouth.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 00:08:22 +1100
Message-ID: <6233.1009976902@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jan 2002 07:46:12 -0500, 
Albert Cranford <ac9410@bellsouth.net> wrote:
>Hello Ollie,
>Small problem.
>I cannot build kernel with binutils-2.11.92.0.12.3
>
>drivers/sound/trident.o(.data+0x154): undefined reference to `local symbols in discarded section .text.exit'
>+#ifdef DEVEXIT_LINKED
>        remove:         trident_remove,
>+#endif

What is DEVEXIT_LINKED?  The correct form is
	remove:		__devexit_p(trident_remove),

