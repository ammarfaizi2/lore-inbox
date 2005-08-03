Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVHCKt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVHCKt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVHCKtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:49:25 -0400
Received: from main.gmane.org ([80.91.229.2]:11942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262208AbVHCKsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:48:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrey Melnikoff <temnota+news@kmv.ru>
Subject: Re: [PATCH 2.4.31 1/1] scsi/megaraid2: add 64-bit application sup?port
Date: Wed, 3 Aug 2005 14:44:16 +0400
Message-ID: <0pj6s2-grt.ln1@kenga.kmv.ru>
References: <0E3FA95632D6D047BA649F95DAB60E5703662A89@exa-atlanta>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kenga.kmv.ru
Cancel-Lock: sha1:AymUAYmVBwGtSVq8pVVjvMNnLcQ=
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.4.31 (i686))
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann <sju@lsil.com> wrote:
> [-- text/plain, encoding 7bit, charset: iso-8859-1, 1346 lines --]

> Hi Marcelo,

> I've made changes that reflect your comments.

> On Tuesday, July 26, 2005 4:33 AM, Marcelo Tosatti wrote:
> > vary_io has never been part of mainline. How come did you add it
> > here?
> Has removed '.vary_io'.
> > There is no CONFIG_COMPAT on v2.4... thanks James and Christoph
> > for reviewing.
> Has removed 'CONFIG_COMPAT'.

> Thank you.

> Signed-off-by: Seokmann Ju <seokmann.ju@lsil.com>
Still not compile with gcc-3.4

-- cut --
gcc-3.4 -D__KERNEL__ -I/usr/src/linux-2.4.31/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-fno-unit-at-a-time   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=megaraid2  -c -o megaraid2.o megaraid2.c
megaraid2.c: In function `megaraid_queue':
megaraid2.h:1113: sorry, unimplemented: inlining failed in call to
'mega_runpendq': function body not available
megaraid2.c:1033: sorry, unimplemented: called from here
megaraid2.c: In function `mega_n_to_m':
megaraid2.c:4658: warning: unused variable `uiocp'
make[3]: *** [megaraid2.o] Error 1

-- cut --

