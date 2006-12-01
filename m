Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031536AbWLAQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031536AbWLAQKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031533AbWLAQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:10:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58503 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031530AbWLAQKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:10:40 -0500
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
	hyper-threading.
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1164985757.5257.933.camel@gullible>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607733630-git-send-email-bcollins@ubuntu.com>
	 <20061201132918.GB4239@ucw.cz>  <1164980500.5257.922.camel@gullible>
	 <1164983529.3233.73.camel@laptopd505.fenrus.org>
	 <1164985757.5257.933.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Dec 2006 17:10:36 +0100
Message-Id: <1164989436.3233.85.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm just basing this on the history of the patch, which preceeds me, so
> if this is incorrect, please don't blame me for misinformation :)
> 
> The original patch claims that hyper-threading opens the user up to some
> sort of security risk involving hardware limitations in protecting
> memory across the threads. I can't recall all the details.
> 
> If this is wrong, I'm more than happy to just drop the whole damn patch.

that is not correct.
I suspect what is meant is the "attack" on older openssl versions where
you could in theory get SOME information about a key in use by snooping
cache patterns in a shared cache situation. By no means is it a "direct"
leak of any kind, and openssl has since then been fixed to not have as
many key-dependent execution streams anymore.

I would suggest you drop the patch; openssl has been long fixed, and it
was only a theoretical attack in the first place...
I'm not saying the attack isn't something that should be addressed.. but
it is, and disabling hyperthreading is not the right fix.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

