Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVKJKvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVKJKvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVKJKvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:51:49 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:34454 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1750774AbVKJKvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:51:49 -0500
Subject: Re: latest mtd changes broke collie
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Todd Poynor <tpoynor@mvista.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051110103823.GB2401@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz>
	 <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz>
	 <1131616948.27347.174.camel@baythorne.infradead.org>
	 <20051110103823.GB2401@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:51:43 +0000
Message-Id: <1131619903.27347.177.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 11:38 +0100, Pavel Machek wrote:
> That said... I can certainly do few experiments. Switching map_name
> from "sharp" to "cfi" should be theoretically enough to get new code
> up?

That's if the chips are actually compliant with the Common Flash
Interface. Otherwise, use the 'jedec_probe' method to identify them,
which will still end up using the same actual back-end driver.

-- 
dwmw2


