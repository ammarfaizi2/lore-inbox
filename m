Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280904AbRKLTne>; Mon, 12 Nov 2001 14:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKLTnY>; Mon, 12 Nov 2001 14:43:24 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:3087 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280904AbRKLTnN>;
	Mon, 12 Nov 2001 14:43:13 -0500
Date: Mon, 12 Nov 2001 12:42:23 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011112124223.D26373@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Oct 2001 18:49:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 11:01:56AM -0800, Linus Torvalds wrote:
> 
> Which means that I'd also like people to double-check that there are no
> embarrassing missing pieces due to the merge (or other patches).

This tiny patch to arch/i386/config.in is needed to be able to select
the PCI Hotplug driver so that it can be used.

thanks,

greg k-h


diff --minimal -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Nov 12 11:34:30 2001
+++ b/arch/i386/config.in	Mon Nov 12 11:34:30 2001
@@ -234,8 +234,10 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   source drivers/hotplug/Config.in
 else
    define_bool CONFIG_PCMCIA n
+   define_bool CONFIG_HOTPLUG_PCI n
 fi
 
 bool 'System V IPC' CONFIG_SYSVIPC

