Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULBIWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULBIWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbULBIWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:22:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:46821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261425AbULBIWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:22:21 -0500
Date: Thu, 2 Dec 2004 00:21:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make gconfig work with gtk-2.4
Message-Id: <20041202002155.5ce64e20.akpm@osdl.org>
In-Reply-To: <1101949263l.27549l.0l@werewolf.able.es>
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101949263l.27549l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> I need this to make gconfig work under gtk-2.4. Without this, it just
>  coredumps. There is some problem with pixmap creation/usage from XPM in
>  the way it is done in gconf, so I just added some stock icons. It is even prettier..;)
> 
>  Could someone test this still works on gtk-2.0 or 2.2 ?


Seems to work OK here with gtk-1.2 and gtk-2.0.

1.2 spews lots of:


(gconf:27745): GLib-GObject-WARNING **: gobject.c:1002:g_object_set_property(): object class `GtkCellRendererToggle' has no property named `inconsistent'

(gconf:27745): GLib-GObject-WARNING **: gobject.c:1002:g_object_set_property(): object class `GtkCellRendererToggle' has no property named `inconsistent'

(gconf:27745): GLib-GObject-WARNING **: gobject.c:1002:g_object_set_property(): object class `GtkCellRendererToggle' has no property named `inconsistent'

and 2.0 whines a bit:

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): libglade-WARNING **: unknown widget class 'GtkToolButton'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be3f8'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be238'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be388'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be468'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be4d8'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be2a8'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be318'

(gconf:1484): GLib-GObject-WARNING **: gsignal.c:1893: signal `clicked' is invalid for instance `0x80be1c8'

(gconf:1484): GLib-GObject-WARNING **: invalid cast from `GtkLabel' to `GtkButton'

(gconf:1484): Gtk-CRITICAL **: file gtkbutton.c: line 553 (gtk_button_clicked): assertion `GTK_IS_BUTTON (button)' failed
