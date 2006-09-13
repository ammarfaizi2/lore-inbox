Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWIMAjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWIMAjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWIMAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751412AbWIMAja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:39:30 -0400
Date: Tue, 12 Sep 2006 17:39:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-audit@redhat.com
Subject: Re: [git pull] audit updates and fixes
In-Reply-To: <20060912071429.GB29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0609121737460.4388@g5.osdl.org>
References: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk> <20060911180346.c4bfd211.akpm@osdl.org>
 <20060912071429.GB29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Sep 2006, Al Viro wrote:
> 
>  arch/i386/kernel/audit.c             |   51 ---------------------------
>  b/arch/i386/kernel/Makefile          |    1
>  b/arch/ia64/Kconfig                  |    4 ++
>  b/arch/powerpc/Kconfig               |    4 ++
>  b/arch/s390/Kconfig                  |    4 ++
>  b/arch/sparc64/Kconfig               |    4 ++
>  b/arch/sparc64/kernel/Makefile       |    3 +
>  b/arch/sparc64/kernel/audit.c        |   66 +++++++++++++++++++++++++++++++++++
>  b/arch/sparc64/kernel/compat_audit.c |   37 +++++++++++++++++++
>  b/arch/x86_64/Kconfig                |    4 ++
>  b/lib/Kconfig                        |    5 ++
>  b/lib/Makefile                       |    1
>  b/lib/audit.c                        |   53 ++++++++++++++++++++++++++++
>  13 files changed, 185 insertions(+), 52 deletions(-)

Btw, if you do "git diff --stat --summary -M", you'd have gotten

 arch/i386/kernel/Makefile          |    1 -
 arch/ia64/Kconfig                  |    4 ++
 arch/powerpc/Kconfig               |    4 ++
 arch/s390/Kconfig                  |    4 ++
 arch/sparc64/Kconfig               |    4 ++
 arch/sparc64/kernel/Makefile       |    3 ++
 arch/sparc64/kernel/audit.c        |   66 ++++++++++++++++++++++++++++++++++++
 arch/sparc64/kernel/compat_audit.c |   37 ++++++++++++++++++++
 arch/x86_64/Kconfig                |    4 ++
 lib/Kconfig                        |    5 +++
 lib/Makefile                       |    1 +
 {arch/i386/kernel => lib}/audit.c  |    2 +
 12 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100644 arch/sparc64/kernel/audit.c
 create mode 100644 arch/sparc64/kernel/compat_audit.c
 rename arch/i386/kernel/audit.c => lib/audit.c (97%)

instead, which is much nicer. It shows the rename, and the summary info 
also points out that some of the files were newly created.

		Linus
