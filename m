Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUHIRE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUHIRE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUHIRE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:04:56 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:29632 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266749AbUHIREZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:04:25 -0400
Date: Mon, 9 Aug 2004 13:04:23 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Michael Buesch <mbuesch@freenet.de>
cc: Albert Cahalan <albert@users.sf.net>, Greg KH <greg@kroah.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic /dev security hole?
In-Reply-To: <200408091854.27019.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.58.0408091302010.9426@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com> <200408091530.55244.mbuesch@freenet.de>
 <1092057570.5761.215.camel@cube> <200408091854.27019.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Aug 2004, Michael Buesch wrote:
> So what about this updated patch?

>  		dbg("unlinking symlink '%s'", filename);
> - -		retval = unlink(filename);
> - -		if (errno == ENOENT)
> - -			retval = 0;
> - -		if (retval) {
> - -			dbg("unlink(%s) failed with error '%s'",
> - -				filename, strerror(errno));
> +		retval = secure_unlink(filename);

Better not do it for symlinks.

Eric
