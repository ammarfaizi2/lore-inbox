Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSJ0XV4>; Sun, 27 Oct 2002 18:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSJ0XV4>; Sun, 27 Oct 2002 18:21:56 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:8136 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S262750AbSJ0XV4>; Sun, 27 Oct 2002 18:21:56 -0500
Date: Sun, 27 Oct 2002 16:27:55 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
Message-ID: <20021027162755.A19334@mail.harddata.com>
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at> <20021027111856.GA789@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021027111856.GA789@alpha.home.local>; from willy@w.ods.org on Sun, Oct 27, 2002 at 12:18:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 12:18:56PM +0100, Willy Tarreau wrote:
> And I also
> agree that mtab shouldn't be under /etc (this is the only file that needs to
> be written to). At least, it should be moved to /var/state or something like
> that, provided it's available early in the boot stage,

I was just looking at these things I found few more such files in
/etc.  Like /etc/adjtime, /etc/mrtg/<something> and /etc/.aumixrc.
I consider all of these user-space bugs.  There are also /etc/passwd
and /etc/shadow which will be written to if you are changing
passwords while not using something like NIS.  This is, in a sense,
a harder case but one can live with that.

   Michal
