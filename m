Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWJCIEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJCIEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWJCIEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:04:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18701 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030224AbWJCIES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:04:18 -0400
Date: Tue, 3 Oct 2006 08:03:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dong Feng <middle.fengdong@gmail.com>,
       Christoph Lameter <clameter@sgi.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Message-ID: <20061003080352.GA4078@ucw.cz>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com> <451E8143.5030300@yahoo.com.au> <200609301703.45364.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609301703.45364.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-09-06 17:03:45, Andi Kleen wrote:
> 
> > Did you get to the bottom of this yet? It looks like you're right,
> > and I suggest a seqlock might be a good option.
> 
> It basically doesn't matter because nobody changes the time zone after boot.

Attacker might; in a tight loop, to confuse time-of-day subsystem, or
maybe oops the kernel.
							Pavel

-- 
Thanks for all the (sleeping) penguins.
