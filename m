Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbREVQ6e>; Tue, 22 May 2001 12:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbREVQ60>; Tue, 22 May 2001 12:58:26 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:49177 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262655AbREVQ6T>; Tue, 22 May 2001 12:58:19 -0400
Date: Tue, 22 May 2001 17:57:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Theodore Tso <tytso@valinux.com>,
        Andrew McNamara <andrewm@connect.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010522175759.S8080@redhat.com>
In-Reply-To: <20010522174825.Q8080@redhat.com> <Pine.LNX.4.30.0105221152400.19818-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105221152400.19818-100000@waste.org>; from oxymoron@waste.org on Tue, May 22, 2001 at 11:54:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2001 at 11:54:55AM -0500, Oliver Xymoron wrote:

> > > > That's probably the right thing to add.
> > >
> > > I'd vote for an async flag instead.
> >
> > Why???  Why change the default behaviour to be something much slower?
> 
> I was suggesting an async flag _in addition_ to the sync flag, both
> propagating to subdirs. Nice and orthogonal.

The whole problem is that the flag applies to both files and
directories, but we often only want it enforced on directories
(because we already have fsync for files).  Adding another orthogonal
file+dir async flag won't help that at all.

Cheers,
 Stephen
