Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVCPPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVCPPMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVCPPMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:12:38 -0500
Received: from smtp06.auna.com ([62.81.186.16]:31176 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262616AbVCPPMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:12:13 -0500
Date: Wed, 16 Mar 2005 15:07:12 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-mm4
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1110985632l.8879l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.16, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> 
...
>
> +revert-gconfig-changes.patch
> 
>  Back out a recent change which broke gconfig.
> 

What was broken ?

Now it does not work:

werewolf:/usr/src/linux# make gconfig
  HOSTCC  scripts/kconfig/gconf.o
In file included from /usr/include/gtk-2.0/gtk/gtkactiongroup.h:34,
                 from /usr/include/gtk-2.0/gtk/gtk.h:38,
                 from scripts/kconfig/gconf.c:16:
/usr/include/gtk-2.0/gtk/gtkitemfactory.h:53: warning: function declaration isn't a prototype
scripts/kconfig/gconf.c: In function `init_main_window':
scripts/kconfig/gconf.c:225: error: `xpm_single_view' undeclared (first use in this function)
scripts/kconfig/gconf.c:225: error: (Each undeclared identifier is reported only once
scripts/kconfig/gconf.c:225: error: for each function it appears in.)
scripts/kconfig/gconf.c:235: error: `xpm_split_view' undeclared (first use in this function)
scripts/kconfig/gconf.c:245: error: `xpm_tree_view' undeclared (first use in this function)
scripts/kconfig/gconf.c: At top level:
scripts/kconfig/gconf.c:973: warning: 'renderer_toggled' defined but not used
make[1]: *** [scripts/kconfig/gconf.o] Error 1
make: *** [gconfig] Error 2


An if you just open gconf.glade with glade-2 and just _save_ it without
doing nothing, it changes a lot of things.

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam4 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #1




