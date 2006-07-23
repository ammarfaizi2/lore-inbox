Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWGWM7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGWM7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 08:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGWM7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 08:59:04 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:5774 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751201AbWGWM7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 08:59:03 -0400
Date: Sun, 23 Jul 2006 14:58:15 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060723125815.GB7776@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723053755.0aaf9ce0.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton:
> Also the sched-domain migration costs are grossly different between the two
> kernels.  Maybe we changed the migration-cost-estimation code; I forget.
> 
The old values look suspicious. 4000 and 8000 ??

Maybe there was some excess delay or wait time in the estimator.

The only code in the kernel I'd accept to take exactly 4000 of *anything*
without further investigation is a call to "mdelay(4)".  ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Silence is the element in which great things fashion themselves.
		-- Thomas Carlyle
