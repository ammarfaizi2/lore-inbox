Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLMAcX>; Tue, 12 Dec 2000 19:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLMAcM>; Tue, 12 Dec 2000 19:32:12 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:21539 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129324AbQLMAcB>; Tue, 12 Dec 2000 19:32:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ronis@onsager.chem.mcgill.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: Build failure in 2.2.18 
In-Reply-To: Your message of "Tue, 12 Dec 2000 09:39:31 CDT."
             <200012121439.eBCEdVo25972@ronispc.chem.mcgill.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Dec 2000 11:01:21 +1100
Message-ID: <6885.976665681@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000 09:39:31 -0500, 
root <ronis@ronispc.chem.mcgill.ca> wrote:
>I've just patched and reconfigured to 2.2.18 (from 2.2.17 on an
>i686-linux-gnu[2.2]).  make bzImage fails with:
>ld:/usr/src/linux/arch/i386/vmlinux.lds:73: parse error
>  /* Stabs debugging sections.  */
>  .
>   stab 0 : { *(.stab) }
>  .stabstr 0 : { *(.stabstr) }

arch/i386/vmlinux.lds is generated from arch/i386/vmlinux.lds.S, using
$(CPP).  It looks like your version of cpp is doing something very
strange to the text, it has split '.stab 0 : { *(.stab) }' over two
lines.  I do not see this with egcs 2.91.66, what does gcc -v report?

Try removing arch/i386/vmlinux.lds and running make bzImage again, that
will create a fresh copy of vmlinux.lds.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
