Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUL3TvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUL3TvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUL3TvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:51:03 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:63574 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261704AbUL3Tu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:50:58 -0500
Message-ID: <41D45C1F.5030307@tls.msk.ru>
Date: Thu, 30 Dec 2004 22:50:55 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Peter T. Breuer" <ptb@lab.it.uc3m.es>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       dm-crypt@saout.de
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <m38y7fn4ay.fsf@reason.gnu-hamburg> <v3rda2-hjn.ln1@news.it.uc3m.es>
In-Reply-To: <v3rda2-hjn.ln1@news.it.uc3m.es>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter T. Breuer wrote:
> In gmane.linux.raid Georg C. F. Greve <greve@fsfeurope.org> wrote:
> 
> Yes, well, don't put the journal on the raid partition. Put it
> elsewhere (anyway, journalling and raid do not mix, as write ordering
> is not - deliberately - preserved in raid, as far as I can tell).

This is a sort of a nonsense, really.  Both claims, it seems.
I can't say for sure whenever write ordering is preserved by
raid -- it should, and if it isn't, it's a bug and should be
fixed.  Nothing else is wrong with placing journal into raid
(the same as the filesystem in question).  Suggesting to remove
journal just isn't fair: the journal is here for a reason.
And, finally, the kernel should not crash.  If something like
this is unsupported, it should refuse to do so, instead of
crashing randomly.

/mjt
