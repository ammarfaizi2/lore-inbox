Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130742AbQJ1CWA>; Fri, 27 Oct 2000 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQJ1CVu>; Fri, 27 Oct 2000 22:21:50 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35087 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130742AbQJ1CVi>;
	Fri, 27 Oct 2000 22:21:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
cc: Linus Torvalds <torvalds@transmeta.com>, Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] generic_serial's block_til_ready (fwd) 
In-Reply-To: Your message of "Fri, 27 Oct 2000 15:27:04 +0200."
             <Pine.LNX.4.21.0010271523290.16091-100000@panoramix.bitwizard.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 13:21:32 +1100
Message-ID: <5150.972699692@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 15:27:04 +0200 (CEST), 
Patrick van de Lageweg <patrick@bitwizard.nl> wrote:
>This patch renames the block_til_ready of generic serial to
>gs_block_til_ready. This patch also exports the symbols needed by other
>modules with generic_serial compiled into the kernel.
>
>(it also helps when other modules have a "static block_til_ready"
>defined. This IMHO is a bug in the module-utils, but I'm told it
>cannot be fixed becuase of backwards compatibility.... Grrr. -- REW)

modutils for kernel 2.5 will break that backwards compatibility, it
goes all the way back to 2.0 kernels.  But if I broke backwards
compatibility just before 2.4 kernel release, there would be a lynch
mob headed my way.  In any case, block_til_ready is too generic a name
for an exported symbol.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
