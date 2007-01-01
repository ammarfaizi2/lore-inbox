Return-Path: <linux-kernel-owner+w=401wt.eu-S932750AbXAASgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbXAASgt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 13:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbXAASgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 13:36:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36405 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932750AbXAASgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 13:36:48 -0500
Date: Mon, 1 Jan 2007 19:36:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Amit Choudhary <amit2030@yahoo.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DISCUSS] Make the variable NULL after freeing it.
Message-ID: <20070101183641.GA4593@elf.ucw.cz>
References: <88880.94256.qm@web55601.mail.re4.yahoo.com> <200701011709.48349.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701011709.48349.ioe-lkml@rameria.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I decided to keep it simple. If someone is calling kfree_nullify() with anything other than a
> > simple variable, then they should call kfree().
> 
> kfree_nullify() has to replace kfree() to be of any use one day. So this is not an option.
> 

Doing kfree() that writes to its argument is not an option. kfree()
looks like a function, so it should behave as one. KFREE() might be
okay.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
