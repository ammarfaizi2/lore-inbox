Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRDBPbL>; Mon, 2 Apr 2001 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRDBPav>; Mon, 2 Apr 2001 11:30:51 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:32516 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S129638AbRDBPal>;
	Mon, 2 Apr 2001 11:30:41 -0400
Date: Mon, 2 Apr 2001 11:28:40 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Ian Soboroff <ian@cs.umbc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/config idea
In-Reply-To: <3AC89389.46317572@coplanar.net>
Message-ID: <Pine.LNX.4.30.0104021120330.3912-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see benefit in having the .config file in the kernel.  It being a non
loadable elf section would be a plus.  However I also see merit to having
it available as a proc entry.

Say that we decide to go with /proc/config.  In that case I think that
Jeremy is right on with the compressing of the info.

linux-2.4.3# cat .config | grep ^CONFIG_ | wc -c
   2885

linux-2.4.3# cat .config | grep ^CONFIG_ | gzip | wc -c
    874

While 3k is not a lot, >1k would be even better.  The /proc/config could
just unzip the compressed config stored in the kernel on the fly.

This would reduce the 'bloat'.  Of course this functionality would be
configurable and maybe off by default.  Although if it's not available on a
default kernel of distribution X, Y and Z there is little merit in it as
install scripts for 3rd party drivers could not reliably use it.

Cheers,
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/


