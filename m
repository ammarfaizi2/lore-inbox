Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbTHKNKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTHKNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:10:40 -0400
Received: from smtp3.libero.it ([193.70.192.127]:7342 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S272521AbTHKNKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:10:39 -0400
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <daps_mls@libero.it>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20030811124744.GB1733@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
	 <20030807214311.GC211@elf.ucw.cz>
	 <1060334463.5037.13.camel@defiant.flameeyes>
	 <20030808231733.GF389@elf.ucw.cz>
	 <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
	 <20030811124744.GB1733@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060607466.5035.8.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 15:11:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 14:47, Pavel Machek wrote:
> I converted lirc_gpio into input/ layer (and killed support for
> hardware I do not have; sorry but it was essential to keep code
> small). Ported driver looks like this; I believe it looks better than
> old code. Patch is here.
You can here see the problem... not all tv cards use the same remote,
the switch doesn't work with my remote for example, so we have 2
possibilities:

a) hardcode all the possible remotes adding these as new one come up,
this is a big work in the kernel source, and also we lost compatibility
with remotes that use the same frequency of the ones with the tv card,
and that now can be used.

b) create an userspace utility that read the input layer for codes an
then translates them in user-definable commands. This is what lircd do
now...

IMHO, the solution used now is the more flexible of the two.
-- 
Flameeyes <dgp85@users.sf.net>

