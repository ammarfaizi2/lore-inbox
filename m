Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTLAEQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 23:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLAEQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 23:16:10 -0500
Received: from pine.epix.net ([199.224.64.53]:55985 "EHLO pine.epix.net")
	by vger.kernel.org with ESMTP id S263260AbTLAEQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 23:16:03 -0500
From: Dosoverride <dosoverride@epix.net>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test11] gconfig does not build cleanly
Date: Mon, 1 Dec 2003 04:15:44 +0000
User-Agent: KMail/1.5.4
References: <200311300610.40705.dosoverride@epix.net> <200311300816.24749.sam@ravnborg.org>
In-Reply-To: <200311300816.24749.sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xBsy/GOMbmO8q4v"
Message-Id: <200312010416.01913.dosoverride@epix.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xBsy/GOMbmO8q4v
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 30 November 2003 07:16 am, Sam Ravnborg wrote:
> On Sunday 30 November 2003 07:10, Dosoverride wrote:
> > [make O=~/kernel-build-tree/test mrproper clean gconfig ]
> >
> > [excerpt of make command with alternate tree ]
> > ./scripts/kconfig/gconf  arch/i386/Kconfig
> >
> > (gconf:14841): libglade-WARNING **: could not find glade file
> > '/home/dosoverride/kernel-build-tree/test//scripts/kconfig/gconf.glade'
> > 	   							             ^ (seems to be the problem)
> > ** ERROR **: GUI loading failed !
>
> Hi John.
> The problem is know and a fix exist.
> Usually reported as xconfig build fails with make O=
> The fix did not pass Linus' current patchfilter - it is not critical - so
> it will be applied later. Until now here it is.
>
> [Nw mailer, so apologize if it is whitespace damaged]
>
> 	Sam

patch didn't stop erring.
I redirected all output to a file (attached) (plus added some hash comments)

However, xconfig did work correctly.

John
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ysB2ifWyBgvkFZ0RAhlSAJ0enWe26S6ImQ2nEJgcvuIolUm/KACfaQEY
xp0tBp3x0nR5vTZK6nWTKMw=
=Lk/8
-----END PGP SIGNATURE-----

--Boundary-00=_xBsy/GOMbmO8q4v
Content-Type: text/plain;
  charset="iso-8859-1";
  name="build.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build.out"

#make file for gconfig test using O=
#made Dec 1, 0407 UTC
#applied patch rev-1.1296.61.2.patch
#make O=~/kernel-build-tree/test mrproper clean gconfig
  RM  $(CLEAN_FILES)
  Making mrproper in the srctree
  RM  $(MRPROPER_DIRS) + $(MRPROPER_FILES)
  RM  $(CLEAN_FILES)
  HOSTCC  scripts/fixdep
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
sed < /usr/src/linux-2.6.0-test11/scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  HOSTCC  scripts/kconfig/gconf.o
In file included from /usr/include/gtk-2.0/gtk/gtk.h:90,
                 from /usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c:17:
/usr/include/gtk-2.0/gtk/gtkitemfactory.h:51: warning: function declaration isn't a prototype
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c: In function `on_treeview1_button_press_event':
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c:1175: warning: passing arg 1 of `gtk_widget_grab_focus' from incompatible pointer type
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c: In function `update_tree':
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c:1404: warning: unused variable `path'
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c: In function `display_tree':
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c:1530: warning: suggest parentheses around && within ||
/usr/include/stdlib.h: At top level:
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:6: warning: `xpm_load' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:36: warning: `xpm_save' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:66: warning: `xpm_back' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:175: warning: `xpm_symbol_no' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:192: warning: `xpm_symbol_mod' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:209: warning: `xpm_symbol_yes' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:226: warning: `xpm_choice_no' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:243: warning: `xpm_choice_yes' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:277: warning: `xpm_menu_inv' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/images.c:294: warning: `xpm_menuback' defined but not used
/usr/src/linux-2.6.0-test11/scripts/kconfig/gconf.c:981: warning: `renderer_toggled' defined but not used
  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/gconf
./scripts/kconfig/gconf  arch/i386/Kconfig

(gconf:23254): libglade-WARNING **: could not find glade file '/home/dosoverride/kernel-build-tree/test//scripts/kconfig/gconf.glade'

** ERROR **: GUI loading failed !

aborting...
make[2]: *** [gconfig] Aborted
make[1]: *** [gconfig] Error 2
make: *** [gconfig] Error 2

--Boundary-00=_xBsy/GOMbmO8q4v--

