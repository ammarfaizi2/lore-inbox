Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262390AbSJIXOJ>; Wed, 9 Oct 2002 19:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJIXOJ>; Wed, 9 Oct 2002 19:14:09 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:51841 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262390AbSJIXOI>;
	Wed, 9 Oct 2002 19:14:08 -0400
Date: Thu, 10 Oct 2002 00:20:02 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021009232002.GC2654@bjl1.asuk.net>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009222438.GD5608@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
>     2) Pages should not be candidates for dropping if the pages belong
>        to the first few pages of a file. (First = 2? 4? 8?) The theory
>        being, that somebody could begin reading the file again from the
>        beginning.

This breaks the benefit of using O_STREAMING to read a lot of small
files once, as you might do when grepping the kernel tree for example.

-- Jamie
