Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRIDUUz>; Tue, 4 Sep 2001 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRIDUUf>; Tue, 4 Sep 2001 16:20:35 -0400
Received: from [208.48.139.185] ([208.48.139.185]:411 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S268901AbRIDUUY>; Tue, 4 Sep 2001 16:20:24 -0400
Date: Tue, 4 Sep 2001 13:20:39 -0700
From: David Rees <dbr@greenhydrant.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS to Irix server broken again in 2.4.9
Message-ID: <20010904132039.A18908@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15253.1002.189305.674221@barley.abo.fi> <20010904120737.A17459@greenhydrant.com> <shswv3eena8.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shswv3eena8.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Sep 04, 2001 at 10:03:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 10:03:43PM +0200, Trond Myklebust wrote:
> >>>>> " " == David Rees <dbr@greenhydrant.com> writes:
> 
>      > Previous 2.4.X kernels didn't require the 32bitclients option
>      > on the IRIX server for some reason.
> 
> That was because prior to 2.4.9 the kernel would automatically
> truncate the getdents() offsets to 32 bits. We now have true 64 bit
> offsets, and they actually get passed back to userland.
> 
> glibc-2.x's 32 bit version of readdir() still assumes that
> getdents64() syscall returns some an offset (rather than a cookie) and
> that the offset fits into 32bits on ordinary directories.
> Using '32bitclients' on these older IRIX servers sort of shoehorns
> them into the glibc assumptions in the same way the 32 bit truncation
> in kernels 2.4.[0-8] did.

Hmm, the the server I'm running is IRIX 6.5.12 which isn't that old.  IRIX
6.5.13 was only released a little while ago (with some specific IRIX/Linux
NFS fixes according to the changelog) so I assume that with 6.5.13 we won't
need the 32bitclients options.

Thanks for the info.

-Dave
