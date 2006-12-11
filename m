Return-Path: <linux-kernel-owner+w=401wt.eu-S937439AbWLKS3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937439AbWLKS3J (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763006AbWLKS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:29:09 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37493 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763005AbWLKS3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:29:08 -0500
Date: Mon, 11 Dec 2006 10:29:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] kconfig: Only activate UI save widgets when .config
 changed; Take 3
Message-Id: <20061211102927.c8a0fa48.randy.dunlap@oracle.com>
In-Reply-To: <200612111408.51647.fzu@wemgehoertderstaat.de>
References: <200610180023.04978.annabellesgarden@yahoo.de>
	<20061210001044.bd1ea97e.akpm@osdl.org>
	<200612111408.51647.fzu@wemgehoertderstaat.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 14:08:51 +0100 Karsten Wiese wrote:

> Am Sonntag, 10. Dezember 2006 09:10 schrieb Andrew Morton:
> > 
> > So I'm pretending to be kbuild maintainer and I now realise I simply don't
> > know what this patch series does.
> > 
> > Can you please explain it a lot more?
> 
> lets "make xconfig" on a freshly untarred kernel-tree.
> look at the floppy disk icon of the qt application, that has just started:
> Its in a normal, active state.
> Mouse click on it:
> .config is being saved.
> Now in the current -mm head version, you'll notice something new:
> after the mouse click on the floppy disk icon, the icon is greyed out.
> If you mouse click on it now, nothing happens, which is ok IMHO,
> as nothing has changed.
> If you change some CONFIG_*, the floppy disk icon returns to "active state",
> that is, if you mouse click it now, .config is written.
> The "icon greying out" aka "save widget de/activation" is done by this
> patch series.
> Its done for the save-icons and the file-save menu entries of the
> applications launched after "make xconfig" or "make gconfig" is called.
> Purpose is: 
> "let the (gtk/qt kernel configuration) application show me if there are
>  unsaved changes to the .config,
>  so there's 1 thing less I might wonder about"
> 
> more?

I reviewed the patches and tested menu/x/gconfig.
They all look good to me.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Thanks,
---
~Randy
