Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIWLSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIWLSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWIWLSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:18:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5303 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750696AbWIWLSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:18:07 -0400
Date: Sat, 23 Sep 2006 13:18:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Message-ID: <20060923111805.GF20778@elf.ucw.cz>
References: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Note that I don't think PowerOp would cover all devices. In fact, I
> think most devices would remain autonomous or controlled as part of
> specific subsystems. The only things that PowerOp would bundle together
> would be things that aren't independent (and may not even be visible as
> "devices" in the usual Linux sense), but that have to be managed
> together in changing frequency/voltage. At least, that's the way I
> imagined it would work.

Well, two objections to that

a) current powerop code does not handle 256 CPU machine, because that
would need 256 independend bundles, and powerop has hardcoded "only
one bundle" rule.

b) having some devices controlled by powerop and some by specific
subsystem is indeed ugly. I'd hope powerop would cover all the
devices. (Or maybe cover _no_ devices). Userland should not need to
know if touchscreen is part of SoC or if it happens to be independend
on given machine.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
