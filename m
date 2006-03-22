Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWCVP4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWCVP4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWCVP4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:56:30 -0500
Received: from pat.uio.no ([129.240.130.16]:9703 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750806AbWCVP43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:56:29 -0500
Subject: Re: DoS with POSIX file locks?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: chrisw@sous-sol.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1FM2Gi-0001LF-00@dorka.pomaz.szeredi.hu>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
	 <1142962083.7987.37.camel@lade.trondhjem.org>
	 <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
	 <20060321191605.GB15997@sorel.sous-sol.org>
	 <E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu>
	 <1143025967.12871.9.camel@lade.trondhjem.org>
	 <E1FM2Gi-0001LF-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:56:16 -0500
Message-Id: <1143042976.12871.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.333, required 12,
	autolearn=disabled, AWL 1.67, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 13:16 +0100, Miklos Szeredi wrote:
> > > > i concur with Trond, there's no sane way to get rid of it w/out
> > > > formalizing CLONE_FILES and locks on exec
> > > 
> > > Probably there is.  It would involve allocating a separate
> > > lock-owner-ID stored in files_struct but separate from it.  But it's
> > > more complicated than simply not propagating locks on exec in the
> > > CLONE_FILES case.
> > 
> > That doesn't solve the fundamental problem.
> > 
> > You would still have to be able to tell a remote server that some locks
> > which previously belonged to one owner are being reallocated to several
> > owners.
> 
> No changing of lock owner is involved, that's the whole point.

You still don't get it. For NFS/CIFS/... the locks on the server _also_
have a lock owner. The local lockowner is completely and utterly
irrelevant.

Cheers,
  Trond

