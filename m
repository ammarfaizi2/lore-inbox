Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSEMRx2>; Mon, 13 May 2002 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSEMRx1>; Mon, 13 May 2002 13:53:27 -0400
Received: from mail.eskimo.com ([204.122.16.4]:45838 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S314291AbSEMRx0>;
	Mon, 13 May 2002 13:53:26 -0400
Date: Mon, 13 May 2002 10:52:50 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Elladan <elladan@eskimo.com>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020513105250.A30395@eskimo.com>
In-Reply-To: <elladan@eskimo.com> <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:09:15PM -0400, Horst von Brand wrote:
> Elladan <elladan@eskimo.com> said:
> 
> [...]
> 
> > Regardless of whether it's a good thing to depend on security-wise, it
> > is a problem to have something that appears to be a security feature
> > which doesn't actually work.
> 
> It is _not_ a security feature, it is meant to keep the filesystem from
> fragmenting too badly. root can use that space, since root can do whatever
> she wants anyway.

But it *appears* to be a security feature.  Thus, someone might
incorrectly depend on it, unless it's clearly documented as otherwise.
This is probably best considered a documentation issue.  Instead of
saying it's "reserved for root" etc., tools should indicate it's
"reserved to prevent fragmentation, still accessible by root"

At least one document I recall seeing indicates that this reserve is so
system software (eg. cron jobs) won't fail, and so root will still be
able to log in when the disk is full.  This interpretation makes it
sound like a security feature - if it isn't meant as one, some effort
should be made to ensure there's no confusion, or else someone might
depend on the behavior.

-J
