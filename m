Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWHaIfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHaIfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHaIfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:35:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:52952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751403AbWHaIfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:35:30 -0400
X-Authenticated: #14349625
Subject: Re: A nice CPU resource controller
From: Mike Galbraith <efault@gmx.de>
To: balbir@in.ibm.com
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Martin Ohlin <martin.ohlin@control.lth.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F67EE2.5060605@in.ibm.com>
References: <44F5AB45.8030109@control.lth.se>
	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
	 <44F6365A.8010201@bigpond.net.au>  <44F67EE2.5060605@in.ibm.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:44:40 +0000
Message-Id: <1157021080.5770.88.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 11:47 +0530, Balbir Singh wrote:

> It's my belief that time and priorities are orthogonal. Nice does a good job
> of trying to mix the two,  but in the case of resource management it might not
> be such a good idea.

I don't think they're orthogonal.  If two tasks of identical priority
are contending for cpu, and you choose the one with more time on it's
group ticket, you have effectively modified priorities.

Regardless, nice sounded attractive to me at first, but it's flat wrong
to use a per task variable to store group scope information, so I have
to agree that nice isn't a good choice for group resource management.

	-Mike

