Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSKSGHt>; Tue, 19 Nov 2002 01:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbSKSGHt>; Tue, 19 Nov 2002 01:07:49 -0500
Received: from netrealtor.ca ([216.209.85.42]:42000 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267102AbSKSGHs>;
	Tue, 19 Nov 2002 01:07:48 -0500
Date: Tue, 19 Nov 2002 01:22:05 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Grant Taylor <gtaylor+lkml_ihdeh111902@picante.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119062205.GC17927@mark.mielke.cc>
References: <200211190549.gAJ5nGmU007542@habanero.picante.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211190549.gAJ5nGmU007542@habanero.picante.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 12:49:16AM -0500, Grant Taylor wrote:
> For example, sometimes TCP reads return EAGAIN when in fact they have
> data.  This seems to stem from the case where the signal is found
> before the first segment copy (from tcp.c circa 1425, there's even a
> handy FIXME note there).  If you use epoll and get an EAGAIN, you have
> no idea if it was a signal or a real empty socket unless you are also
> very careful to notice when you got a signal during the read.

I hope this isn't a stupid question: Why doesn't the code you speak of
return EINTR instead of EAGAIN?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

