Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRGCEHt>; Tue, 3 Jul 2001 00:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbRGCEHj>; Tue, 3 Jul 2001 00:07:39 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:19250 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S263766AbRGCEH0>;
	Tue, 3 Jul 2001 00:07:26 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jakub Jelinek <jakub@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kernel linker scripts 
In-Reply-To: Your message of "Mon, 02 Jul 2001 11:53:51 -0400."
             <20010702115351.B11623@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jul 2001 14:06:48 +1000
Message-ID: <813.994133208@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001 11:53:51 -0400, 
Jakub Jelinek <jakub@redhat.com> wrote:
>Apparently all kernel scripts only have .rodata and not also .rodata.* input
>sections in it.
>-  .rodata : { *(.rodata) }
>+  .rodata : { *(.rodata) *(.rodata.*) }

Any reason not to use *(.rodata*) to cover all rodata sections?  I see
no need for two input definitions, one works for me.

