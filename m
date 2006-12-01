Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031533AbWLAQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031533AbWLAQOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031543AbWLAQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:14:15 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:16043 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1031533AbWLAQOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:14:14 -0500
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
	hyper-threading.
From: Ben Collins <ben.collins@ubuntu.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1164989436.3233.85.camel@laptopd505.fenrus.org>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607733630-git-send-email-bcollins@ubuntu.com>
	 <20061201132918.GB4239@ucw.cz>  <1164980500.5257.922.camel@gullible>
	 <1164983529.3233.73.camel@laptopd505.fenrus.org>
	 <1164985757.5257.933.camel@gullible>
	 <1164989436.3233.85.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 11:14:02 -0500
Message-Id: <1164989642.5257.938.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 17:10 +0100, Arjan van de Ven wrote:
> > I'm just basing this on the history of the patch, which preceeds me, so
> > if this is incorrect, please don't blame me for misinformation :)
> > 
> > The original patch claims that hyper-threading opens the user up to some
> > sort of security risk involving hardware limitations in protecting
> > memory across the threads. I can't recall all the details.
> > 
> > If this is wrong, I'm more than happy to just drop the whole damn patch.
> 
> that is not correct.
> I suspect what is meant is the "attack" on older openssl versions where
> you could in theory get SOME information about a key in use by snooping
> cache patterns in a shared cache situation. By no means is it a "direct"
> leak of any kind, and openssl has since then been fixed to not have as
> many key-dependent execution streams anymore.
> 
> I would suggest you drop the patch; openssl has been long fixed, and it
> was only a theoretical attack in the first place...
> I'm not saying the attack isn't something that should be addressed.. but
> it is, and disabling hyperthreading is not the right fix.

Thanks for clearing that up. Patch withdrawn.
