Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVCPSe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVCPSe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCPSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:34:47 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:64890 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262732AbVCPSds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:33:48 -0500
Date: Wed, 16 Mar 2005 19:33:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050316183358.GA8634@mars.ravnborg.org>
References: <20050316040654.62881834.akpm@osdl.org> <1110985632l.8879l.0l@werewolf.able.es> <20050316182215.GA8267@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316182215.GA8267@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 07:22:15PM +0100, Sam Ravnborg wrote:
> On Wed, Mar 16, 2005 at 03:07:12PM +0000, J.A. Magallon wrote:
> > 
> > On 03.16, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> > > 
> > ...
> > >
> > > +revert-gconfig-changes.patch
> > > 
> > >  Back out a recent change which broke gconfig.
> > > 
> > 
> > What was broken ?
> 
> It did not display the nice icons with gtk2.4 anymore.
> And the fact that it generates ~10 warnings when being compiled annoy me
> as well. Although I have not had the courage to try to fix this gtk
> stuff.

When compiled:
  HOSTCC  scripts/kconfig/gconf.o
  In file included from /usr/include/gtk-2.0/gtk/gtkactiongroup.h:34,
                   from /usr/include/gtk-2.0/gtk/gtk.h:38,
                   from scripts/kconfig/gconf.c:16:
/usr/include/gtk-2.0/gtk/gtkitemfactory.h:53: warning: function declaration isn't a prototype
scripts/kconfig/gconf.c:941: warning: `renderer_toggled' defined but not used
				    


When executed:
scripts/kconfig/gconf arch/i386/Kconfig

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed

(gconf:8782): Gtk-WARNING **: Mixing deprecated and non-deprecated
GtkToolbar API is not allowed
make[1]: *** [gconfig] Interrupt


This is with gtk2.0.

	Sam
