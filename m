Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCLPi3>; Mon, 12 Mar 2001 10:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCLPiT>; Mon, 12 Mar 2001 10:38:19 -0500
Received: from smtp24.singnet.com.sg ([165.21.101.204]:19462 "EHLO
	smtp24.singnet.com.sg") by vger.kernel.org with ESMTP
	id <S130454AbRCLPiK>; Mon, 12 Mar 2001 10:38:10 -0500
Message-ID: <3AACED42.39DF0A24@magix.com.sg>
Date: Tue, 13 Mar 2001 00:37:38 +0900
From: Anthony <anthony@magix.com.sg>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Should mount --bind not follow symlinks?
In-Reply-To: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Don't mix symlinks with mounts/bindings. Too much PITA and yes, it had
> been deliberately prohibited. You _really_ don't want to handle the
> broken symlinks and all the realted fun [...]

No. But I hoped _you_ might :-)

> - race-ridden at extreme and useless.
> In automount-like setups you can _replace_ symlinks with bindings.
> No need to mix them.

Hmm.  My /etc/auto.opt contains

*       :/export/opt/&/LATEST

where all the "LATEST"s etc are symlinks.  I found it quite
an elegant way to maintain different versions: the symlink
was de-facto a trivially simple version database.

Does the version state now *have* to be listed in
/etc/auto.opt explicitly?  That feels a little retrograde.

Perhaps I'm blissfully unaware of all sorts of vile
race conditions, but why can't the *automounter* chase
the symlinks even if mount shouldn't?  Or am I missing
a neater solution?

Rgds

Anthony
