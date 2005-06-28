Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVF1SKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVF1SKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVF1SK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:10:29 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:49157 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262183AbVF1SJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:09:27 -0400
Date: Tue, 28 Jun 2005 20:15:53 +0200
To: Al Boldi <a1426z@gawab.com>
Cc: "'Nix'" <nix@esperi.org.uk>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
Message-ID: <20050628181553.GA18045@aitel.hist.no>
References: <87r7em69h2.fsf@amaterasu.srvr.nix> <200506281147.OAA20216@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506281147.OAA20216@raad.intranet>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:47:15PM +0300, Al Boldi wrote:
> On 28 Jun 2005, Al Boldi murmured woefully:
> > Kswapd starts evicting processes to fullfil a malloc, when it should 
> > just deny it because there is no swap.
> Nix wrote:
> > I can't even tell what you're expecting. Surely not that no pages are ever
> evicted or flushed;
> > your memory would fill up with page cache in no time.
> 
> Nix,
> Please do flush anytime, and do it in sync during OOMs; but don't evict
> procs especially not RUNNING procs, that is overkill.

Something running rarely gets thrown out - It is usually only pages
that see little use that gets evicted.  Such as startup code.

Of course you can improve the situation a lot by adding swap - the kernel
will then be free to swap out dirty but little-used pages instead
of not-dirty but more used executable mappings. That will improve
your performance.

Getting more memory or running fewer programs also helps, obviously.

Helge Hafting
