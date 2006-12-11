Return-Path: <linux-kernel-owner+w=401wt.eu-S1762897AbWLKNI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762897AbWLKNI5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762901AbWLKNI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:08:57 -0500
Received: from mout2.freenet.de ([194.97.50.155]:37381 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762897AbWLKNI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:08:56 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] kconfig: Only activate UI save widgets when .config changed; Take 3
Date: Mon, 11 Dec 2006 14:08:51 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <200610180023.04978.annabellesgarden@yahoo.de> <20061210001044.bd1ea97e.akpm@osdl.org>
In-Reply-To: <20061210001044.bd1ea97e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612111408.51647.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. Dezember 2006 09:10 schrieb Andrew Morton:
> 
> So I'm pretending to be kbuild maintainer and I now realise I simply don't
> know what this patch series does.
> 
> Can you please explain it a lot more?

lets "make xconfig" on a freshly untarred kernel-tree.
look at the floppy disk icon of the qt application, that has just started:
Its in a normal, active state.
Mouse click on it:
.config is being saved.
Now in the current -mm head version, you'll notice something new:
after the mouse click on the floppy disk icon, the icon is greyed out.
If you mouse click on it now, nothing happens, which is ok IMHO,
as nothing has changed.
If you change some CONFIG_*, the floppy disk icon returns to "active state",
that is, if you mouse click it now, .config is written.
The "icon greying out" aka "save widget de/activation" is done by this
patch series.
Its done for the save-icons and the file-save menu entries of the
applications launched after "make xconfig" or "make gconfig" is called.
Purpose is: 
"let the (gtk/qt kernel configuration) application show me if there are
 unsaved changes to the .config,
 so there's 1 thing less I might wonder about"

more?

      Karsten
