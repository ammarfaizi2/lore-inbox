Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRJRKAe>; Thu, 18 Oct 2001 06:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277649AbRJRKAZ>; Thu, 18 Oct 2001 06:00:25 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:39694 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S277636AbRJRKAO>;
	Thu, 18 Oct 2001 06:00:14 -0400
Date: Thu, 18 Oct 2001 11:55:41 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
cc: linux-kernel@vger.kernel.org, Paul Gortmaker <p_gortmaker@yahoo.com>,
        vonbrand@sleipnir.valparaiso.cl, willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Making diff(1) of linux kernels faster 
In-Reply-To: <200110180802.f9I82Mm21621@irishsea.craig-wood.com>
Message-ID: <Pine.LNX.4.21.0110181141040.9091-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Nick Craig-Wood wrote:

> Date: Thu, 18 Oct 2001 09:02:22 +0100
> From: Nick Craig-Wood <ncw@axis.demon.co.uk>
> To: linux-kernel@vger.kernel.org
> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, vonbrand@sleipnir.valparaiso.cl,
>      willy tarreau <wtarreau@yahoo.fr>
> Subject: Re: Making diff(1) of linux kernels faster 
> 
> Horst von Brand wrote:
> > =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> said:
> > > Be very careful not to modify a multi-linked file, or
> > > it will be damaged in all trees and won't be seen by
To be sure it is not possible to modify original tree files, I do
chown -R root.root original_tree

before copying it (via cp -lR) to new one, which will be modified with
whatever tools by me, logged in as a regular user. For those having root
access to a box this might be a useful way of preventing accidents ...
(this of course also assumes sane file permissions)
[...]
> > > diff. your editor must unlink before saving.
> > 
> > Most don't. ed(1), vi(1) and emacs(1) are careful tro write to the very
> > same file. jed(1) is the only outlier I'm aware of...
> 
> emacs does mv file file~ before saving file so the edited file will
> not be linked byt the backup file will be.  You can stop it doing this
> by setting backup-by-copying-when-linked.
> 
Best regards,

Wojtek

--------------------
Wojtek Pilorz
Wojtek.Pilorz@bdk.pl


