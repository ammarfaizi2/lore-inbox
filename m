Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267874AbTAHQQl>; Wed, 8 Jan 2003 11:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267805AbTAHQQk>; Wed, 8 Jan 2003 11:16:40 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:8097 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267874AbTAHQQi>;
	Wed, 8 Jan 2003 11:16:38 -0500
Date: Wed, 8 Jan 2003 16:29:07 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Set TIF_IRET in more places
Message-ID: <20030108162906.GA5995@bjl1.asuk.net>
References: <87isx2dktj.fsf@egil.codesourcery.com> <20030107111905.GA949@bjl1.asuk.net> <87of6s3gm3.fsf@egil.codesourcery.com> <20030107172128.A9592@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107172128.A9592@twiddle.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Tue, Jan 07, 2003 at 11:27:32AM -0800, Zack Weinberg wrote:
> > > It explicitly checks for the opcode sequences 0x58b877000000cd80 and
> > > 0xb8ad000000cd80 in order to unwind exception frames around a
> > > handled signal.  Ugly, isn't it?
> > 
> > We're open to better ideas ...
> 
> Something like having dwarf2 unwind information for the
> vsyscall page on the page as well?

It would be quite nice just to have dwarf2 unwind information, with an
unwind handler, for the classic non-vsyscall restorer in Glibc.

Then MD_FALLBACK_FRAME_STATE_FOR could be removed from GCC on all
Linux targets, regardless of kernel version.

Once that is working it will be much clearer what exactly to send
Linus for the vsyscall page.

-- Jamie
