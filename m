Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318769AbSHGSkw>; Wed, 7 Aug 2002 14:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSHGSkw>; Wed, 7 Aug 2002 14:40:52 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:63200 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318769AbSHGSkv>;
	Wed, 7 Aug 2002 14:40:51 -0400
Date: Thu, 8 Aug 2002 04:43:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, julliard@winehq.com,
       ldb@ldb.ods.org
Subject: Re: [patch] tls-2.5.30-A1
Message-Id: <20020808044343.4e48268c.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>
	<Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002 11:33:23 -0700 (PDT) Linus Torvalds <torvalds@transmeta.com> wrote:
>
>  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
>    GDT entry #8) is available to a TLS entry, since if I remember
>    correctly, that one is also magical for old Windows binaries for all
>    the wrong reasons (ie it was some system data area in DOS and in 
>    Windows 3.1)

segment 0040 is used by the APM driver to work around bugs in some BIOS
implementations where some (brain-dead) BIOS writer has assume that the
BIOS data area is still available in protected mode ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
