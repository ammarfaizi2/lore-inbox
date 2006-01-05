Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWAEBWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWAEBWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAEBWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:22:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:45199 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751114AbWAEBWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:22:47 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: 2.6.15-ck1
References: <200601041200.03593.kernel@kolivas.org>
	<20060104190554.GG10592@redhat.com>
	<20060104195726.GB14782@redhat.com>
	<1136406837.2839.67.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 05 Jan 2006 02:22:37 +0100
In-Reply-To: <1136406837.2839.67.camel@laptopd505.fenrus.org>
Message-ID: <p73y81vxyci.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:


> sounds like we need some sort of profiler or benchmarker or at least a
> tool that helps finding out which timers are regularly firing, with the
> aim at either grouping them or trying to reduce their disturbance in
> some form.

I did one some time ago for my own noidletick patch. Can probably dig
it out again. It just profiled which timers interrupted idle.

Executive summary for my laptop: worst was the keyboard driver (it ran
some polling driver to work around some hardware bug, but fired very
often) , followed by the KDE desktop (should be mostly
fixed now, I complained) and the X server and some random kernel 
drivers.

I haven't checked recently if keyboard has been fixed by now.

-Andi

