Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277735AbRJIOpQ>; Tue, 9 Oct 2001 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277732AbRJIOpK>; Tue, 9 Oct 2001 10:45:10 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22064 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277731AbRJIOo4>; Tue, 9 Oct 2001 10:44:56 -0400
Date: Tue, 9 Oct 2001 16:44:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009164417.G15943@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0110091057470.5604-100000@freak.distro.conectiva> <3BC30B9F.9060609@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC30B9F.9060609@wipro.com>; from balbir.singh@wipro.com on Tue, Oct 09, 2001 at 08:07:19PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:07:19PM +0530, BALBIR SINGH wrote:
> their pages can even be swapped out if needed. But for a device that is not willing
> to wait (GFP_ATOMIC) say in an interrupt context, this might be a issue.

There's just a reserved pool for atomic allocations. See the __GFP_WAIT
check in __alloc_pages.

Andrea
