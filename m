Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVLULXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLULXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVLULXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:23:15 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:17930 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932368AbVLULXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:23:14 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as
 non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de>
	<87d5jru67j.fsf@amaterasu.srvr.nix>
	<20051220155839.GA9185@mars.ravnborg.org>
	<87irtjslxx.fsf@amaterasu.srvr.nix>
	<20051220202559.GK27946@ftp.linux.org.uk>
	<87psnqnb3z.fsf@amaterasu.srvr.nix>
	<20051221081843.GL27946@ftp.linux.org.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Wed, 21 Dec 2005 11:22:03 +0000
In-Reply-To: <20051221081843.GL27946@ftp.linux.org.uk> (Al Viro's message of
 "Wed, 21 Dec 2005 08:18:43 +0000")
Message-ID: <87hd92n19g.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Al Viro stated:
> On Wed, Dec 21, 2005 at 07:49:20AM +0000, Nix wrote:
>> Well, personally I handle patch-application in cp -al'ed trees by doing
>> cp -al via a script, and repatching all currently hardlinked trees
>> (obviously if they are very divergent some patches will fail and I'll
>> have to fix them up by hand).
> 
> ... then you edit a file to fix a typo, and have a _nice_ day next Friday
> when you notice that stuff got out of sync.

Your text editor is insufficiently flexible. Mine can snap hardlinks
automatically when st_nlink > 1. :)

(But let's avoid editor wars. I'm sure there's a magic way vim can be
coerced into doing things properly.)


What we really need is an FS that does behind-the-scenes block CoW
and/or block merging anyway; then we could just cp -a the damn tree
and keep the space savings.

>> (And if you're using this to maintain development branches, then you
>> have resync and conflict-management problems *anyway*, which this makes
>> no worse.)
> 
> Yes, but it's easier to deal with when the number of your repositories
> doesn't get multiplied by factor of 20 or so...

Er, I don't have a factor of 20 more repositories than anyone else. (I
don't have the disk space for that!)

-- 
`I must caution that dipping fingers into molten lead
 presents several serious dangers.' --- Jearl Walker
