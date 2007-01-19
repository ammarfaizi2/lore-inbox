Return-Path: <linux-kernel-owner+w=401wt.eu-S965135AbXASNhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbXASNhc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbXASNhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:37:31 -0500
Received: from ns1.suse.de ([195.135.220.2]:51503 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965135AbXASNhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:37:31 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
X-Yow: Now KEN is having a MENTAL CRISIS because his "R.V." PAYMENTS are
 OVER-DUE!!
Date: Fri, 19 Jan 2007 14:37:29 +0100
In-Reply-To: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
	(Robert P. J. Day's message of "Fri, 19 Jan 2007 06:56:54 -0500
	(EST)")
Message-ID: <jefya7jfxi.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>   first, there appear to be three possible ways of specifying an
> inline routine in the kernel source:
>
>   $ grep -r "static inline " .
>   $ grep -r "static __inline__ " .
>   $ grep -r "static __inline " .
>
> i vaguely recall that this has something to do with a distinction
> between C99 inline and gcc inline

No, it doesn't (there is no C99 compatible inline in gcc before 4.3).  It
has to do with the fact that inline is not a keyword in C89, so you need
to use a different spelling when you want to stay compatible with strict
C89.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
