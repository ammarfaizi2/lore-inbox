Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275750AbRJNQ3o>; Sun, 14 Oct 2001 12:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275759AbRJNQ3f>; Sun, 14 Oct 2001 12:29:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:25763 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275758AbRJNQ32> convert rfc822-to-8bit;
	Sun, 14 Oct 2001 12:29:28 -0400
Date: Sun, 14 Oct 2001 12:29:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <20011014192258.R1074@niksula.cs.hut.fi>
Message-ID: <Pine.GSO.4.21.0110141226130.6026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Ville Herva wrote:

> FYI, this causes the last mount process to hang in D state (kill -KILL does
> not affect it):
> 
> $ mount --bind -o nosuid,noexec,ro /bin /tmp/test
> $ mount --bind -o nosuid,noexec,ro /bin /tmp/test
> $ mount --bind -o remount,nosuid,noexec,ro /tmp/test

What version of mount(8)?  Or, better yet, how about
strace -e trace=mount,umount
of the whole thing?

