Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275041AbRJBOSp>; Tue, 2 Oct 2001 10:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274570AbRJBOSg>; Tue, 2 Oct 2001 10:18:36 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:6148 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274270AbRJBOST>; Tue, 2 Oct 2001 10:18:19 -0400
Date: Tue, 2 Oct 2001 10:18:45 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stateful Magic Sysrq Key
Message-ID: <20011002101845.A1630@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011002084807.3579.qmail@web20505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002084807.3579.qmail@web20505.mail.yahoo.com>; from wtarreau@yahoo.fr on Tue, Oct 02, 2001 at 10:48:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 02/10/01 10:48 +0200 - willy tarreau:
> > I'd suggest either making this behaviour optional,
> or making it
> > so that hitting alt-sysrq twice, without any other
> keys being
> > pressed makes the next key stick.
> 
> I agree with you that there's a risk. Mike Harris had
> written a
> patch for 2.2 which did something similar, but
> slightly better 
> IMO since it avoids risks of mis-press, handles
> correctly
> broken keyboards and keeps compatible with the
> existing 
> method. Basically, it allows the user to press Alt,
> then SysRQ,
> release SysRQ then press the desired key, and later
> release
> Alt. In fact, it only resets the "magic-key-mode" flag
> after Alt
> has been released, and doesn't bother when SysRq is
> released.

But this would require that alt be pressed. This is not acceptable on
exactly the sort of boards which require this patch.

I will look at adding a 'sysrq-sticky' entry to proc, which will do the
obvious thing. I think that this should address everyone's concerns.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
