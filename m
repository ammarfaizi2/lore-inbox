Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWGKQBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWGKQBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWGKQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:01:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11907 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751075AbWGKQBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:01:30 -0400
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change
	pstate at same time
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Joachim Deguara <joachim.deguara@amd.com>,
       Mark Langsdorf <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <1152634538.18028.23.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
	 <p73fyhdpqe1.fsf@verdi.suse.de> <1152622554.4489.32.camel@lapdog.site>
	 <200607111507.39079.ak@suse.de>
	 <1152623675.3128.41.camel@laptopd505.fenrus.org>
	 <1152634538.18028.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 18:01:23 +0200
Message-Id: <1152633683.3128.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 17:15 +0100, Alan Cox wrote:
> Ar Maw, 2006-07-11 am 15:14 +0200, ysgrifennodd Arjan van de Ven:
> > if you have per cpu offset and speed, then you don't even need to tie
> > all frequencies together... sounds like the best solution to me..
> 
> CPU clocks on some systems are not stable relative to one another. Doing
> the maths only works if you know the divergence isn't cause by
> independant clock sources

obviously you do math only on your local cpu, with the values for your
local cpu. And just never ever look at tsc values from another cpu,
consider them entirely uncorrelated for all I care ;)

Within those constraints it should be reasonably ok (there still is trouble 
if the tsc stops entirely in idle, but thats a different thing)

