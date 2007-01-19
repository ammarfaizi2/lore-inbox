Return-Path: <linux-kernel-owner+w=401wt.eu-S932858AbXASTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbXASTYG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbXASTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:24:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36950 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863AbXASTYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:24:05 -0500
Subject: Re: Threading...
From: Arjan van de Ven <arjan@infradead.org>
To: Brian McGrew <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org, fedora-users@rdhat.com
In-Reply-To: <C1D65587.16E59%brian@visionpro.com>
References: <C1D65587.16E59%brian@visionpro.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 19 Jan 2007 20:23:40 +0100
Message-Id: <1169234620.3055.563.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> And on FC5 I am using pthread_self but my problem isn't simply with
> pthread_self, it's with the scheduling. 

maybe your kernel has a broken scheduler loadbalancing? you really
shouldn't have to do this manually. At all.

>  On FC3 both threads run
> simultaneously in almost symmetric parallel.  On FC5 one thread don't pick
> up and start until the previous one is done.  On FC3, using getpid for the
> thread I could use set_afinity to force each thread to its own processor and
> with FC5 I can't; so I've got one idle processor all the time.

again you can use gettid() or pthread_self() in that call (but remember
it's a bitmask not a number); but really you shouldn't have to do this.
Try a kernel which has a non-broken load balancer?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

