Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUCHQgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUCHQgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:36:22 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:60935 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262691AbUCHQgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:36:13 -0500
Date: Mon, 8 Mar 2004 10:36:11 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308163611.GA8219@hexapodia.org>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org> <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078738772.4678.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 10:39:32AM +0100, Arjan van de Ven wrote:
> > Note that there are some applications for which it is a *bug* if an
> > mlocked page gets written out to magnetic media.  (gpg, for example.)
> 
> mlock() does not guarantee things not hitting magnetic media, just as
> mlock() doesn't guarantee that the physical address of a page doesn't
> change. mlock guarantees that you won't get hard pagefaults and that you
> have guaranteed memory for the task at hand (eg for realtime apps and
> oom-critical stuff)

Well, that's fine -- you can certainly define mlock to have whatever
semantics you want.  But the semantics that gpg depends on are
reasonable, and if mlock is changed to have other semantics, there
should be some way for apps to get the behavior that used to be
implemented by mlock (and *documented* in the mlock man page).

It's a pity that mlock doesn't take a flags argument.

-andy
