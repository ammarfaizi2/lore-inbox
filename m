Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131338AbQKZXZs>; Sun, 26 Nov 2000 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130767AbQKZXZi>; Sun, 26 Nov 2000 18:25:38 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:39274 "EHLO sgi.com")
        by vger.kernel.org with ESMTP id <S131930AbQKZXZU>;
        Sun, 26 Nov 2000 18:25:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: initdata for modules? 
In-Reply-To: Your message of "Sun, 26 Nov 2000 07:30:44 -0800."
             <200011261530.HAA09799@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Nov 2000 09:54:57 +1100
Message-ID: <1175.975279297@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000 07:30:44 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	In reading include/linux/init.h, I was surprised to discover
>that __init{,data} expands to nothing when compiling a module.
>I was wondering if anyone is contemplating adding support for
>__init{,data} in module loading, to reduce the memory footprints
>of modules after they have been loaded.

It has been discussed a few times but nothing was ever done about it.
AFAIK the savings were not seen to be that important because modules
occupy complete pages.  __init would have to be stored in a separate
page which was then discarded.  It would complicate insmod, rmmod,
ksymoops and gdb.  gdb against the kernel already gets confused by
vmlinux data that is discarded and gdb has problems with modules at the
best of times.  Definitely 2.5 material, if at all.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
