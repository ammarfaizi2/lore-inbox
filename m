Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266957AbTGGMHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266960AbTGGMHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:07:54 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12301 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266957AbTGGMHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:07:51 -0400
Date: Mon, 7 Jul 2003 14:22:23 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: C99 types VS Linus types
Message-ID: <20030707122222.GE10021@merlin.emma.line.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1057579305.747.79.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057579305.747.79.camel@cube>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jul 2003, Albert Cahalan wrote:

> > Speaking of shifting forward to standards:
> >
> > unsigned char foo = 42;
> > char bar[42];
> > sprintf(bar, "%ju", (uintmax_t)foo); // see IEEE Std 1003.1-2001
> >
> > If that's too ugly, write your own [u]intmax_t-to-char[]
> > converter, then only the stack is nasty if uintmax_t is 128
> > bits wide and you're printing an array uint8_t. :-P
> 
> Yes, that is too ugly. It's idealistic code.
> Readability matters more than worrying about
> something which won't happen for over 40 years,
> and won't cause Y2K-style problems even then.

sprintf doesn't lend itself too well to readibility anyways, and we have
these crutches in gcc to check argument types and all that, not to speak
of %n and other time bombs.

-- 
Matthias Andree
