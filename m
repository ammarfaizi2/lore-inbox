Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJ1PID>; Mon, 28 Oct 2002 10:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJ1PHe>; Mon, 28 Oct 2002 10:07:34 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:60069 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261286AbSJ1PG4>;
	Mon, 28 Oct 2002 10:06:56 -0500
Date: Mon, 28 Oct 2002 15:13:09 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andi Kleen <ak@suse.de>, eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028151309.GB16546@bjl1.asuk.net>
References: <20021028151533.D18441@wotan.suse.de> <Pine.GSO.3.96.1021028152012.977D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021028152012.977D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> > It's impossible. There is no space left in struct stat64
> > And adding a new syscall just for that would be severe overkill.
> 
>  Well, possibly more stuff could benefit from new stat syscalls, like a
> st_gen member for inode generations.  And as someone suggested, a version
> number or a length could be specified by the calls this time to permit
> less disturbing expansion in the future. 

It's already there.  The kernel stat64() syscall has a flags argument,
which is unused at the moment.  I presume it's for this purpose.

Glibc aleady uses a version number for its stat() calls, to permit
binary compatible extensions on the user side.

So all the mechanism is there AFAIK.

-- Jamie
