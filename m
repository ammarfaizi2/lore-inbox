Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286330AbRLJRu5>; Mon, 10 Dec 2001 12:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286333AbRLJRuh>; Mon, 10 Dec 2001 12:50:37 -0500
Received: from weta.f00f.org ([203.167.249.89]:38596 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S286330AbRLJRue>;
	Mon, 10 Dec 2001 12:50:34 -0500
Date: Tue, 11 Dec 2001 06:52:39 +1300
From: Chris Wedgwood <cw@f00f.org>
To: ncw@axis.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Colo[u]rs"
Message-ID: <20011210175239.GA13712@weta.f00f.org>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net> <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net> <5.1.0.14.2.20011210024959.01c81c20@whisper.qrpff.net> <1007972036.1237.36.camel@phantasy> <200112101222.fBACMFC17255@irishsea.home.craig-wood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112101222.fBACMFC17255@irishsea.home.craig-wood.com>
User-Agent: Mutt/1.3.24i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 12:22:15PM +0000, ncw@axis.demon.co.uk wrote:

    Can you get colo[u]red memory from user-space?  This would be really
    useful for certain memory intensive applications (I'm thinking of
    large FFT users like mprime/ARMprime here)

By colored I assume you mean such that the pages are allocated to
process in such a way as to increase the cache's effectiveness (using
as many colors as possible and potentially not having too many
instances of the same color in successive pages)?

If so, then under Linux this is presently not possible and probably
never will be.  DaveM did some patches for this a while ago which is
of arguable use for things like sparc32 and MIPS, not sure about
sparc64.

SunOS and (I think) FreeBSD do take into account page coloring when
allocating memory though, I've told for some memory intensive MIPS
applications the performance difference can get as great as 15%, but
this is perhaps because of something else unique to MIPS (there are
ambiguities that mean only having one color present in the TLB for an
application at any one time solves).



  --cw
