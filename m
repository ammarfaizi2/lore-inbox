Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSBZXhL>; Tue, 26 Feb 2002 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSBZXhD>; Tue, 26 Feb 2002 18:37:03 -0500
Received: from dsl-213-023-039-032.arcor-ip.net ([213.23.39.32]:55949 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288980AbSBZXgw>;
	Tue, 26 Feb 2002 18:36:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Steve Lord <lord@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Whither XFS? (was: Congrats Marcelo)
Date: Mon, 25 Feb 2002 01:28:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fqZK-0002NE-00@the-village.bc.nu> <1014764374.5993.183.camel@jen.americas.sgi.com>
In-Reply-To: <1014764374.5993.183.camel@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16f90h-0002rt-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 26, 2002 11:59 pm, Steve Lord wrote:
> Yes jfs went in cleanly, because they reimplemented their filesystem
> from the ground up, and had a large budget to do it. XFS does not fit
> so cleanly because we brought along some features other filesystems did
> not have:
> 
>   o Posix ACL support

Are you able to leverage the new EA interface?  (Which I still don't like
because of the namespace syntax embedded in the attribute names, btw,
please don't misinterpret silence as happiness.)

>   o The ability to do online filesystem dumps which are coherent with
>     the system call interface

It would be nice if some other filesystems could share that mechanism, do
you think it's feasible?  If not, what's the stumbling block?  I haven't
looked at this for some time and there's was some furious work going on
exactly there just before 2.5.  It seems we've at least progressed a
little from the viewpoint that nobody would want that.

>   o delayed allocation of file data

Andrew Morton is working on generic delayed allocation at the vfs level I
believe, why not bang heads with him and see if it can be made to work with
VFS?

>   o DMAPI

It would be nice to have unsucky file events.  But there's been roughly zero
discussion of dmapi on lkml as far as I can see.

> As it is we did all of these, and we seem to have half the Linux NAS
> vendors in the world building xfs into their boxes.

True enough.

-- 
Daniel
