Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130326AbQKIOSV>; Thu, 9 Nov 2000 09:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbQKIOSL>; Thu, 9 Nov 2000 09:18:11 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:18183 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130326AbQKIOSC>;
	Thu, 9 Nov 2000 09:18:02 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: therapy <therapy@endorphin.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: arch/i386/lib/mmx.c no symbols 
In-Reply-To: Your message of "Thu, 09 Nov 2000 14:56:05 BST."
             <20001109145605.A507@ghanima.xxx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2000 01:17:55 +1100
Message-ID: <8747.973779475@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000 14:56:05 +0100, 
therapy <therapy@endorphin.org> wrote:
>arch/i386/lib/mmx.c does not export modversioned symbols.
>
>any module using include/asm-i386/[string.h/string-486.h/page.h]
>with 3DNOW enabled will fail to load.

arch/i386/kernel/i386_ksyms.c exports _mmx_memcpy, mmx_clear_page and
mmx_copy_page, with versions.  What is missing?  More likely you have
been bitten by the broken makefiles.

  mv .config ..
  make mrproper
  mv ../.config .
  make oldconfig
  make dep clean bzImage modules

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
