Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbTJUNFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTJUNFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:05:51 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:30469 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263095AbTJUNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:05:49 -0400
Subject: Re: [2.6.0-test8] Difference between Software Suspend and
	Suspend-to-disk?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xy8veddj7.fsf@kth.se>
References: <200310211315.58585.lkml@kcore.org>
	 <20031021113444.GC9887@louise.pinerecords.com>  <yw1xy8veddj7.fsf@kth.se>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1066741540.2068.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 21 Oct 2003 15:05:40 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 13:40, Måns Rullgård wrote:
> Tomas Szepe <szepe@pinerecords.com> writes:
> 
> >> Software Suspend (EXPERIMENTAL)
> >> Suspend-to-Disk Support
> >
> > They're competing implementations of the same mechanism.
> 
> And neither one works reliably, I might add.  They both appear to save
> the current state to disk, but no matter what I try, I can't make it
> resume properly.

Yep! I must say I cannot resume my system from disk. The kernel always
complains about failing when trying to resume from disk. Also, after
suspending to disk, the swap partition is completely valid, and I don't
need to "mkswap" it. On previous releases of the kernel, when STD
worked, trying to skip resume from disk left the swap partition unusable
(as expected after dumping memory to the swap file).

