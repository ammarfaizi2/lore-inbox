Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSK0UkH>; Wed, 27 Nov 2002 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSK0UkH>; Wed, 27 Nov 2002 15:40:07 -0500
Received: from thunk.org ([140.239.227.29]:17620 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264767AbSK0UkH>;
	Wed, 27 Nov 2002 15:40:07 -0500
Date: Wed, 27 Nov 2002 15:47:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021127204718.GA10163@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Margit Schubert-While <margitsw@t-online.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4.3.2.7.2.20021127143633.00b5fae0@pop.t-online.de> <1038410337.6394.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038410337.6394.44.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 03:18:57PM +0000, Alan Cox wrote:
> On Wed, 2002-11-27 at 13:39, Margit Schubert-While wrote:
> >  >Fortunately, 1.28 didn't get adopted by any distro's as far as I know,
> > It got into Suse 8.1
> 
> I guess thats a bit of showstopper for this change 8(

I forgot about SuSE; yeah, they are using 1.28, but they did take the
patch.  (It's needed regardless of whether or not you're using HTREE
in the kernel; it can cause corrupted directories even if you're not
using ext3 htree's).

That being said, from what I can tell, SuSE does *not* support the
Htree changes, and you would be strongly advised to update to update
to the latest version of e2fsprogs before you enabled HTREE.  The
version of e2fsck that SuSE is missing some checks that detect some
incosistencies in the htree structure (not a bug deal, but it might
miss some corrupted filesystems) and is also missing some endian
bugfixes in the htree code (only a problem if you're using a
big-endian machine).

						- Ted
