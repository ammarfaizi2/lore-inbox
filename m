Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbRGRKBq>; Wed, 18 Jul 2001 06:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267856AbRGRKBg>; Wed, 18 Jul 2001 06:01:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40420 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267855AbRGRKBT>;
	Wed, 18 Jul 2001 06:01:19 -0400
Date: Wed, 18 Jul 2001 06:01:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Fabrizio Ammollo <f.ammollo@reitek.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: mount/umount blocked
In-Reply-To: <3B555AD2.B41EEC56@namesys.com>
Message-ID: <Pine.GSO.4.21.0107180555510.4636-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Hans Reiser wrote:

> Is it reiserfs or ext2 that fails to umount/mount?  Do I understand correctly that is09660 also
> fails to mount/umount?

The real question is what got blocked first. Mounting/unmounting is
serialized, so any new mount/umount will simply wait for that one
to complete.

