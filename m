Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGBXK7>; Tue, 2 Jul 2002 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGBXK6>; Tue, 2 Jul 2002 19:10:58 -0400
Received: from are.twiddle.net ([64.81.246.98]:44778 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S314078AbSGBXK6>;
	Tue, 2 Jul 2002 19:10:58 -0400
Date: Tue, 2 Jul 2002 16:13:22 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020702161322.A7642@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	jlnance@intrex.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru> <20020701090353.B1957@tricia.dyndns.org> <20020701180252.A15288@jurassic.park.msu.ru> <yw1xvg7z1bjz.fsf@gladiusit.e.kth.se> <20020702190544.A23788@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020702190544.A23788@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Jul 02, 2002 at 07:05:44PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 07:05:44PM +0400, Ivan Kokshaysky wrote:
> Unfortunately the libraries _officially_ available for linux are
> from v4. If HP would release something more up to date, the alpha
> iov_len hack would go away.

Do we have any way of recognizing v4 vs v5 binaries?  I don't think
we do.  I'd be willing to call any ECOFF binary an OSF binary, and
ignore the fact that Linux used them in the distant past.

The minimum correct solution is to add a PER_OSF4 to personality.h
and put an osf_readv and osf_writev that, if PER_OSF4, read and frob
the data into kernel buffers and pass that on to the regular syscalls.


r~
