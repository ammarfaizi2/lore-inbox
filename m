Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTDNVgb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTDNVga (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:36:30 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6409 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263901AbTDNVgS (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:36:18 -0400
Date: Mon, 14 Apr 2003 23:48:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect' document.
Message-ID: <20030414214807.GB993@mars.ravnborg.org>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030414193138.GA24870@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414193138.GA24870@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 08:31:44PM +0100, Dave Jones wrote:

> Kernel build system.
> ~~~~~~~~~~~~~~~~~~~~
> - make xconfig now requires the qt libraries.
- An alternative that uses gtk exitst, named 'make gconfig'

> - Try "make KBUILD_VERBOSE=0 <whatever target>". If you like it,
>   put KBUILD_VERBOSE=0 into your environment.
You could mention the much shorter "make V=0" version.

"make help" provides a list of typical targets, including debugging targets such as allnoconfig etc.

> - "make kernel/mm.o" will build the named file, provided a
>   corresponding source exists. This also works for (non-composite)
>   modules.
IIRC this is broken for modules at present.

"make kernel/" will compile all files in a subdirectory and below.


> - There is no need to run 'make dep' at any stage

"make dep" is actually deprecated and for no use since one or
two months ago.


> - The bdflush() syscall is now officially deprecated. The syscall
>   does nothing, and prints a stern warning to users. The functionality
>   is replaced by the pdflush deamons.
Can I safely delete /sbin/update from my initscripts then?

	Sam
