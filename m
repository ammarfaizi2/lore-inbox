Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWDeM>; Wed, 22 Nov 2000 22:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWDeC>; Wed, 22 Nov 2000 22:34:02 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:23653 "EHLO sgi.com")
        by vger.kernel.org with ESMTP id <S129514AbQKWDdt>;
        Wed, 22 Nov 2000 22:33:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: rmk@arm.linux.org.uk (Russell King), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess 
In-Reply-To: Your message of "Wed, 22 Nov 2000 21:54:48 CDT."
             <200011230254.eAN2sm9158656@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 14:03:21 +1100
Message-ID: <3870.974948601@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 21:54:48 -0500 (EST), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>Under NO circumstances should klogd or ksymoops mangle the
>original oops. The raw oops data MUST be completely preserved.
>It is a serious bug that this is not what currently happens.

ksymoops prints the original data followed by the decode, it is clean.

<rant> klogd only prints the decoded data, often gets it wrong and
leaves garbage for ksymoops.  I did a patch to klogd a couple
of years ago and sent it to the maintainer but neither the sysklogd
maintainer nor the distributors seem to care. </rant>

>The hard part of klogd/ksymoops is decoding the code bytes AFAIK.
>The rest is a just a cross between grep and ps -- you search and
>you do symbol lookups. I could throw it together in a few hours,
>minus the disassembly part.

Take a look at the code in ksymoops oops.c before you make rash
statements like that.  It has to handle _all_ architecture messages,
including cross arch debugging.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
