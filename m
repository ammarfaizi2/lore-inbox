Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVIRA40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVIRA40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVIRA40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:56:26 -0400
Received: from xenotime.net ([66.160.160.81]:14793 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751260AbVIRA40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:56:26 -0400
Date: Sat, 17 Sep 2005 17:56:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jesper.juhl@gmail.com
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
Message-Id: <20050917175624.6637140d.rdunlap@xenotime.net>
In-Reply-To: <9a874849050917174635768d04@mail.gmail.com>
References: <m364szk426.fsf@defiant.localdomain>
	<9a874849050917174635768d04@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005 02:46:35 +0200 Jesper Juhl wrote:

> On 17 Sep 2005 19:16:33 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > Hi,
> > 
> > A number of packages (e.g., busybox) use some, more or less broken,
> > version of menuconfig. Would it make sense to move menuconfig to
> > a separate well-defined package?
> > 
> 
> What exactely is it you want to make a sepperate package?
> 
> menuconfig is just a little bit of the kbuild system which also
> includes xconfig, config, gconfig, oldconfig, etc.  menuconfig is just
> a dialog based frontend to the kbuild system which consists of
> configuration options, help texts, dependency info etc.
> 
> menuconfig uses `dialog` to present its menus and dialog boxes (using
> ncurses), and if you want to build something else using dialog, then
> that already exists as a sepperate program that has nothing to do with
> kbuild. On my system (Slackware) it's installed as /bin/dialog and
> comes from the pkgtools-10.2.0-i486-5 package.
> 
> I don't think it makes much sense to split the parts of kbuild that
> make up menuconfig out into a standalone thing. kbuild (and thus
> menuconfig) has little use outside the kernel.  The `dialog` tool is a
> different matter, but that is already a sepperately developed thing (
> http://hightek.org/dialog/ ) .

OTOH, Christoph Hellwig used to maintain 'mconf' out-of-tree
and it worked decently, so it seems not a big deal to so do.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
