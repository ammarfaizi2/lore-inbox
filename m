Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755238AbWKMUPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbWKMUPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbWKMUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:15:52 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:48645 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1755238AbWKMUPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:15:52 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
References: <20061110161355.GB15031@kernel.dk>
	<87u01717qw.fsf@sycorax.lbl.gov> <20061113200256.GC15031@kernel.dk>
Date: Mon, 13 Nov 2006 12:15:41 -0800
In-Reply-To: <20061113200256.GC15031@kernel.dk> (message from Jens Axboe on
	Mon, 13 Nov 2006 21:02:56 +0100)
Message-ID: <87lkmfcdci.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> Great, problem fixed then, patch is already merged upstream so
> 2.6.19 and next -rc (if any :-) should work. Thanks for your
> persistent testing.

i've played with this a little bit more over the weekend. sometimes
cdparanoia gets stuck trying to read some sector. with your patches i
can now stop the process and restart it, and without touching the cd
at all this next time cdparanoia finishes just fine. usually this
happens after i try to rip a series of tracks so i wonder if some
error counters don't get reset or something like that. maybe this is
the expected behaviour, but i don't think i saw cdparanoia get stuck
on the first track ever, usually it happens after some time.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
