Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbRB0XZf>; Tue, 27 Feb 2001 18:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129935AbRB0XZP>; Tue, 27 Feb 2001 18:25:15 -0500
Received: from mail.valinux.com ([198.186.202.175]:25096 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129932AbRB0XZL>;
	Tue, 27 Feb 2001 18:25:11 -0500
Date: Tue, 27 Feb 2001 15:24:37 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Updated patch for the [2.4.x] NFS 'missing directory entry a.k.a. IRIX server' problem...
Message-ID: <20010227152437.A18517@valinux.com>
In-Reply-To: <14997.9938.106305.635202@charged.uio.no> <20010227150432.A18066@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227150432.A18066@valinux.com>; from hjl@valinux.com on Tue, Feb 27, 2001 at 03:04:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 03:04:32PM -0800, H . J . Lu wrote:
> >  	entry->prev_cookie = entry->cookie;
> > -	p = xdr_decode_hyper(p, &entry->cookie);
> > +	p = xdr_decode_hyper(p, cookie);
> > +	entry->cookie = nfs_transform_cookie64(cookie);
> 
> I don't understand this. As far as I can tell, "cookie" is not
> initialized at all. Even if it is initialized, what does
> 
> 	p = xdr_decode_hyper(p, cookie);
> 

Trond, I think you missed

	p = xdr_decode_hyper(p, &cookie);
				^

Yes, it does seem to work.


-- 
H.J. Lu (hjl@valinux.com)
