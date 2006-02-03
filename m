Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWBCTBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWBCTBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWBCTBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:01:17 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:47011 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1422659AbWBCTBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:01:16 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Alexander Fieroch <fieroch@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16rc2] compile error
References: <ds08vk$hk$1@sea.gmane.org>
Date: Fri, 03 Feb 2006 11:01:15 -0800
In-Reply-To: <ds08vk$hk$1@sea.gmane.org> (message from Alexander Fieroch on
	Fri, 03 Feb 2006 19:55:47 +0100)
Message-ID: <87d5i48dxg.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch <fieroch@web.de> writes:

> Hello,
>
> I can't compile kernel 2.6.16-rc[12] and get the following error:
>
> # make
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `set -e; echo '  CHK     include/linux/version.h';
> mkdir -p include/linux/;        if [ `echo -n "2.6.16-rc2 .file null
> .ident GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
> .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo '"2.6.16-rc2
> .file null .ident GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8)
> .section .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1;
> fi; (echo \#define UTS_RELEASE \"2.6.16-rc2 .file null .ident
> GCC:(GNU)4.0.320060128(prerelease)(Debian4.0.2-8) .section
> .note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
> \\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
> << 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6.16rc2/Makefile >
> include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s
> include/linux/version.h include/linux/version.h.tmp; then rm -f
> include/linux/version.h.tmp; else echo '  UPD
> include/linux/version.h'; mv -f include/linux/version.h.tmp
> include/linux/version.h; fi'
> make: *** [include/linux/version.h] Error 2

look at /dev/null. on my system it keeps getting replaced by a regular
file. not really sure where the bug is, but 'cd /dev; ./MAKEDEV null'
will recreate the null character device and then the compilation will
proceed normally.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
