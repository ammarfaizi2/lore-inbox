Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318099AbSIAV2L>; Sun, 1 Sep 2002 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSIAV2L>; Sun, 1 Sep 2002 17:28:11 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:35969 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318099AbSIAV2L>;
	Sun, 1 Sep 2002 17:28:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, davidm@hpl.hp.com
Subject: Re: page-flags.h pollution?
Date: Sun, 1 Sep 2002 23:34:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
References: <200208300556.g7U5up3c025064@napali.hpl.hp.com> <3D6F12A4.285DF44@zip.com.au>
In-Reply-To: <3D6F12A4.285DF44@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lcMi-0004c8-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 August 2002 08:37, Andrew Morton wrote:
> David Mosberger wrote:
> > 
> > In the 2.5.3x kernel, what's the point of defining pte_chain_lock()
> > and pte_chain_unlock() in page-flags.h?  These two routines make it
> > impossible to include page-flags.h on it's own, because they require
> > "struct page" to be defined (and a forward declaration isn't
> > sufficient either).  This can introduce rather annoying circular
> > include-file dependencies.
> 
> It's a wart.  The now-abandoned hashed spinlocking patch moves
> them into <linux/rmap-locking.h>.   We can do that anyway - only
> two files need it.
> 
> Or maybe just put them in asm-generic/rmap.h.   I'll fix it up.

Yup.  As a matter of principle, headers for data should be separated from
headers for operations.

-- 
Daniel
