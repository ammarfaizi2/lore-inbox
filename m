Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbTCHUMz>; Sat, 8 Mar 2003 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbTCHUMz>; Sat, 8 Mar 2003 15:12:55 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:34828 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262177AbTCHUMy>; Sat, 8 Mar 2003 15:12:54 -0500
Date: Sat, 8 Mar 2003 20:23:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308202328.A31942@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@digeo.com>, Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com> <1047086062.24215.14.camel@irongate.swansea.linux.org.uk> <20030308005018.GE23071@kroah.com> <1047136302.25932.28.camel@irongate.swansea.linux.org.uk> <20030308193722.GD26374@kroah.com> <20030308195028.A31394@infradead.org> <20030308200016.GF26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308200016.GF26374@kroah.com>; from greg@kroah.com on Sat, Mar 08, 2003 at 12:00:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 12:00:16PM -0800, Greg KH wrote:
> I've looked at it, and right now it keeps drivers from registering the
> same major number,

No.  Because it doesn't actually register the number anymore.  It's perfectly
valid to have a 2.5 block driver that never calls register_blkdev().

> Yes, most of the old code and logic is now gone, but can you just remove
> the call altogether now?  If so, great :)

We can get rid of it if people have no problem with __bdevname printing
less pretty strings and /proc/devices going away for block devices (which
is buggy now anyway).  I'm all in favour of it.

