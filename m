Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSGBPDp>; Tue, 2 Jul 2002 11:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSGBPDo>; Tue, 2 Jul 2002 11:03:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:12552 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316662AbSGBPDn>; Tue, 2 Jul 2002 11:03:43 -0400
Date: Tue, 2 Jul 2002 19:05:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020702190544.A23788@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru> <20020701090353.B1957@tricia.dyndns.org> <20020701180252.A15288@jurassic.park.msu.ru> <yw1xvg7z1bjz.fsf@gladiusit.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xvg7z1bjz.fsf@gladiusit.e.kth.se>; from mru@users.sourceforge.net on Mon, Jul 01, 2002 at 09:40:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 09:40:48PM +0200, Måns Rullgård wrote:
> Using the libraries from the tru64 5.0 install CD works fine for
> running programs on that CD. There does seem to be some problems with
> different library versions, though. Matlab 5 would not run with libc
> from the tru64 5.0 CD. I had to get some other ones. With the right
> libraries Matlab runs fine with both 2.4.19-rc1 and earlier.

Unfortunately the libraries _officially_ available for linux are
from v4. If HP would release something more up to date, the alpha
iov_len hack would go away.
It looks like in the Tru64 v5 readv/writev compatibility issues
are solved on the libc level. Default (SuS compliant) functions
are _Ereadv/_Ewritev, and readv/writev are just wrappers (clearing
top 32 bits of iov_len) for old binaries.

Ivan.
