Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWEWOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWEWOiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWEWOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:38:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751042AbWEWOiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:38:13 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, mmlnx@us.ibm.com
Subject: Re: nmi_watchdog default setting on i386 and x86_64
References: <44724DE3.2000209@us.ibm.com>
	<17523.6413.711397.401340@alkaid.it.uu.se>
From: Andi Kleen <ak@suse.de>
Date: 23 May 2006 16:37:57 +0200
In-Reply-To: <17523.6413.711397.401340@alkaid.it.uu.se>
Message-ID: <p73psi46c3e.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Mike Mason writes:
>  > Does anybody know the reasoning behind having nmi_watchdog turned off by 
>  > default on i386 and on by default on x86_64.  I've heard that i386 had 
>  > problems with false positives in the past, but that local apic watchdog 
>  > may make that concern obsolete.
> 
> On i386 the problems are mainly hardware and BIOS. In particular,
> lots of Dell laptops have capable hardware but broken BIOSen that
> hang the machines if we try to enable anything sending performance
> counter interrupts via the local APIC.

AFAIK that trouble was mostly when you forced the local APIC on against
the wishes of the BIOS. That was always a dumb idea and gladly
Linux doesn't try that by default anymore.

-Andi

