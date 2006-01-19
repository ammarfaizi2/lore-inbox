Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWASHfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWASHfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWASHfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:35:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8199 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161250AbWASHfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:35:22 -0500
Date: Thu, 19 Jan 2006 08:35:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
Message-ID: <20060119073509.GA8231@mars.ravnborg.org>
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:47:13PM -0800, Miles Lane wrote:
> make all install modules modules_install
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `set -e; echo '  CHK    
> include/linux/version.h'; mkdir -p include/linux/;      if [ `echo -n
> "2.6.16-rc1-git1 .file null .ident
> GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
> '"2.6.16-rc1-git1 .file null .ident
> GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1; fi;
> (echo \#define UTS_RELEASE \"2.6.16-rc1-git1 .file null .ident
> GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> .note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
> \\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
> << 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6/Makefile >
> include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp
> -s include/linux/version.h include/linux/version.h.tmp; then rm -f
> include/linux/version.h.tmp; else echo '  UPD    
> include/linux/version.h'; mv -f include/linux/version.h.tmp
> include/linux/version.h; fi'
> make: *** [include/linux/version.h] Error 2
Do you have any file in your build directory named localversion* ?
That would explain the loon line that includes 
".file null .ident GCC: ..."

Otherwise something else goes in and trigger the long localversion.
The variable CONFIG_LOCALVERSION may also be set to a wrong value in
your environment but this is unlikely.

	Sam
