Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUD1X3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUD1X3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUD1X2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:28:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261887AbUD1X1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:27:41 -0400
Date: Wed, 28 Apr 2004 20:28:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Xavier Wielemans <willy@alterface.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: abort() and exit(1) make RHEL freeze when core size limit is higher than 2 MB
Message-ID: <20040428232847.GE16387@logos.cnet>
References: <5.1.0.14.2.20040421141000.02798b80@mail.fluxtopia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040421141000.02798b80@mail.fluxtopia.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 02:11:19PM +0200, Xavier Wielemans wrote:
> [ I hope this is a relevant linux-kernel bug - I think so, all apologies if 
> not... ]
> [ Please CC me personally if replying, I'm not subscribed to the list - 
> thank you ! ]
> 
> Hi all,
> 
> I encountered the following problem - when my C++ application executes the 
> abort() or exit(1) system instructions, if the core size limit was 
> previously set to more than ~2MB (ulimit -c 2000), my PC freezes totally 
> and must be power-cycled...
> 
> If the core limit is left untouched to 0 (default), the abort or exit 
> instructions are executed without problems, but of course no core file is 
> dumped !
> 
> If core limit is set to 2000 or less, a core file is dumped but it is 
> unreadable (certainly because it is trimmed to less than its actual size).
> 
> If core limit is set to 4000 or higher (including 'ulimit -c unlimited') 
> the machine freezes as soon as abort() or exit() are executed.
> 
> Here are my configuration details :
> 
> [wielemans@electro:wielemans] cat /etc/redhat-release
> Red Hat Enterprise Linux WS release 3 (Taroon Update 1)
> 
> [wielemans@electro:wielemans] uname -a
> Linux electro 2.4.21-9.0.1.EL #2 Fri Apr 16 13:51:32 CEST 2004 i686 i686 
> i386 GNU/Linux
> 
> [wielemans@electro:wielemans] gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/specs
> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
> --infodir=/usr/share/info --enable-shared --enable-threads=posix 
> --disable-checking --with-system-zlib --enable-__cxa_atexit 
> --host=i386-redhat-linux
> Thread model: posix
> gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-24)
> 
> If you need more details, please ask !  Any help or idea welcome, thanks in 
> advance...

Xavier,

Odd. Is this the latest RH update? Maybe you can try a mainline kernel?
