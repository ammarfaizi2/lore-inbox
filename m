Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSLPSV2>; Mon, 16 Dec 2002 13:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSLPSV2>; Mon, 16 Dec 2002 13:21:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:55306 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266986AbSLPSV1>;
	Mon, 16 Dec 2002 13:21:27 -0500
Date: Mon, 16 Dec 2002 19:29:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc?
Message-ID: <20021216182919.GA1607@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
References: <1357.1039954001@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357.1039954001@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 11:06:41PM +1100, Keith Owens wrote:
> There are two ways of setting the -nostdinc flag in the kernel Makefile :-
> 
> (1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> (2) -nostdinc -iwithprefix include
> 
> The first format breaks with non-English locales, however the fix is trivial.
> 
> (1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> 
Hi Keith.

Based on the comments received, solution (2) seems to be OK.
Do you agree?

	Sam
