Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUK3F2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUK3F2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 00:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUK3F2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 00:28:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:42856 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261988AbUK3F2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 00:28:17 -0500
Date: Tue, 30 Nov 2004 06:28:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: George Anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: A problem with xconfig
Message-ID: <20041130052824.GA8211@mars.ravnborg.org>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <41ABA8E5.4060504@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ABA8E5.4060504@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 02:55:33PM -0800, George Anzinger wrote:
> In looking at the makefile history, it would appear that libkconfig.so has 
> been deleted from the build.  It seems, however, that qconf has not gotten 
> the message:
> 
>  make O=/usr/src/ver/makena/obj/  xconfig ARCH=i386
>   HOSTCXX scripts/kconfig/qconf.o
>   HOSTLD  scripts/kconfig/qconf
> scripts/kconfig/qconf arch/i386/Kconfig
> ./scripts/kconfig/libkconfig.so: cannot open shared object file: No such 
> file or directory
> make[2]: *** [xconfig] Error 1
> make[1]: *** [xconfig] Error 2
> make: *** [xconfig] Error 2

It used to be so but was addressed in a patch to scripts/kconfig/Makefile
a few weeks ago. Do you see it with latest -linus / -mm?

	Sam
