Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVCPXIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVCPXIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVCPXIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:08:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:31724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262871AbVCPXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:03:48 -0500
Date: Wed, 16 Mar 2005 15:03:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-Id: <20050316150329.6469ce45.akpm@osdl.org>
In-Reply-To: <1111012757l.17756l.0l@werewolf.able.es>
References: <20050316040654.62881834.akpm@osdl.org>
	<1110985632l.8879l.0l@werewolf.able.es>
	<20050316132600.3f6e4df2.akpm@osdl.org>
	<1111012757l.17756l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
>  On 03.16, Andrew Morton wrote:
>  > "J.A. Magallon" <jamagallon@able.es> wrote:
>  > >
>  > > On 03.16, Andrew Morton wrote:
>  > >  > 
>  > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
>  > >  > 
>  > >  ...
>  > >  >
>  > >  > +revert-gconfig-changes.patch
>  > >  > 
>  > >  >  Back out a recent change which broke gconfig.
>  > >  > 
>  > > 
>  > >  What was broken ?
>  > 
>  > hm.  I emailed you twice, and had a feeling that things weren't getting
>  > through.
>  > 
>  > The patch caused those little pixmap buttons across the top of the main
>  > window to vanish when using gtk+-1.2.10-28.1.  See
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg.
>  > 
>  > I now note that scripts/kconfig/gconf.c doesn't compile at all with the
>  > above backout patch.  Drat.
>  > 
> 
>  But gconf is not supposed to build with gtk-1.2, it needs 2.x,

I was probably looking at the wrong thing.  This is a Fedora Core 1 system.


bix:/usr/src/25> ldd scripts/kconfig/gconf
        linux-gate.so.1 =>  (0xffffe000)
        libglade-2.0.so.0 => /usr/lib/libglade-2.0.so.0 (0x4d1cf000)
        libgtk-x11-2.0.so.0 => /usr/lib/libgtk-x11-2.0.so.0 (0x4cd14000)
        libxml2.so.2 => /usr/lib/libxml2.so.2 (0x4d6f4000)
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x4c6aa000)
        libz.so.1 => /usr/lib/libz.so.1 (0x4c687000)
        libgdk-x11-2.0.so.0 => /usr/lib/libgdk-x11-2.0.so.0 (0x4cc62000)
        libatk-1.0.so.0 => /usr/lib/libatk-1.0.so.0 (0x4cb4d000)
        libgdk_pixbuf-2.0.so.0 => /usr/lib/libgdk_pixbuf-2.0.so.0 (0x4cc4d000)
        libm.so.6 => /lib/tls/libm.so.6 (0x4c57e000)
        libpangoxft-1.0.so.0 => /usr/lib/libpangoxft-1.0.so.0 (0x4cf64000)
        libpangox-1.0.so.0 => /usr/lib/libpangox-1.0.so.0 (0x4cd05000)
        libpango-1.0.so.0 => /usr/lib/libpango-1.0.so.0 (0x4ccd1000)
        libgobject-2.0.so.0 => /usr/lib/libgobject-2.0.so.0 (0x4cc12000)
        libgmodule-2.0.so.0 => /usr/lib/libgmodule-2.0.so.0 (0x4cc47000)
        libdl.so.2 => /lib/libdl.so.2 (0x4c5a2000)
        libglib-2.0.so.0 => /usr/lib/libglib-2.0.so.0 (0x4cba7000)
        libc.so.6 => /lib/tls/libc.so.6 (0x4c443000)
        libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x4c5a7000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x4c42b000)
        libXrandr.so.2 => /usr/X11R6/lib/libXrandr.so.2 (0x4c900000)
        libXi.so.6 => /usr/X11R6/lib/libXi.so.6 (0x4ca28000)
        libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0x4c69a000)
        libXft.so.2 => /usr/X11R6/lib/libXft.so.2 (0x4c826000)
        libXrender.so.1 => /usr/X11R6/lib/libXrender.so.1 (0x4c7bb000)
        libfontconfig.so.1 => /usr/lib/libfontconfig.so.1 (0x4c7e5000)
        libfreetype.so.6 => /usr/lib/libfreetype.so.6 (0x4c6f3000)
        libexpat.so.0 => /usr/lib/libexpat.so.0 (0x4c799000)
