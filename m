Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSKYAb7>; Sun, 24 Nov 2002 19:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKYAb7>; Sun, 24 Nov 2002 19:31:59 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:5128 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262317AbSKYAb6>; Sun, 24 Nov 2002 19:31:58 -0500
Date: Mon, 25 Nov 2002 00:38:48 +0000
From: John Levon <levon@movementarian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021125003848.GA38088@compsoc.man.ac.uk>
References: <20021119024032.GA99837@compsoc.man.ac.uk> <20021125003005.451342C0E9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125003005.451342C0E9@lists.samba.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18G7Gy-00076O-00*aAmw.aaz0Ek*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:02:00AM +1100, Rusty Russell wrote:

> I implemented the minimal subset: it's trivial to put back.  The
> important question is why do you want it?  Do you only want it when
> CONFIG_MODULES=y?  Do you only want the exported symbols, or all
> symbols?
> 
> If this is for oprofile to figure out where modules are, then an entry
> in /proc/modules seems more appropriate, yes?

Keith Owens pointed out that I need info on where each section is
mapped (consider the separate alloc of init/core sections; sure,
module_init() is an odd thing to profile but it's nice not to lose
samples). I don't care about the symbols themselves, but I believe Keith
does.

regards
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
