Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSLSNcA>; Thu, 19 Dec 2002 08:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLSNcA>; Thu, 19 Dec 2002 08:32:00 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63646 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262394AbSLSNcA>;
	Thu, 19 Dec 2002 08:32:00 -0500
Date: Thu, 19 Dec 2002 13:38:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: bart@etpmod.phys.tue.nl
Cc: torvalds@transmeta.com, lk@tantalophile.demon.co.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, drepper@redhat.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, davej@codemonkey.org.uk, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219133848.GB32524@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	bart@etpmod.phys.tue.nl, torvalds@transmeta.com,
	lk@tantalophile.demon.co.uk, hpa@transmeta.com,
	terje.eggestad@scali.com, drepper@redhat.com,
	matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219132239.4650B51F88@gum12.etpnet.phys.tue.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 02:22:36PM +0100, bart@etpmod.phys.tue.nl wrote:
 > > However, there's another issue, namely process startup cost. I personally 
 > > want it to be as light as at all possible. I hate doing an "strace" on 
 > > user processes and seeing tons and tons of crapola showing up. Just for 
 > So why not map the magic page at 0xffffe000 at some other address as
 > well? 
 > Static binaries can just directly jump/call into the magic page.

.. and explode nicely when you try to run them on an older kernel
without the new syscall magick. This is what Linus' first
proof-of-concept code did.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
