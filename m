Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270176AbRHGKeE>; Tue, 7 Aug 2001 06:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270179AbRHGKdy>; Tue, 7 Aug 2001 06:33:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44042 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270176AbRHGKdn>; Tue, 7 Aug 2001 06:33:43 -0400
Date: Tue, 7 Aug 2001 12:33:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Spreen <david@spreen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807123358.B31832@athlon.random>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>; from david@spreen.de on Tue, Aug 07, 2001 at 04:28:10AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 04:28:10AM +0200, David Spreen wrote:
> Hey there,
> I was just searching for swap-encryption-solutions in the lkml-archive.
> Did I get the point saying ther's no way to do swap encryption
> in linux right now? (Well, a swapfile in an encrypted kerneli
> partition r something like that is not really what I want to
> do I think).

cryptoloop on the blkdev or filebacked should work just fine. However it
will increase memory pressure and it increases the probability for a
deadlock (but normal 2.4 swap activities can deadlock anyways if you do
the math).

Andrea
