Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316152AbSEJWk3>; Fri, 10 May 2002 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316154AbSEJWk3>; Fri, 10 May 2002 18:40:29 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:52986 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316152AbSEJWk1>;
	Fri, 10 May 2002 18:40:27 -0400
Date: Fri, 10 May 2002 15:40:26 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches on the way...
Message-ID: <20020510154026.A14407@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Time to dump my current batch of IrDA patches in the
kernel. That will help the current "warning message" squashing
party. Tested on 2.5.15.
	Regards,

	Jean

-----------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir253_smc_msg.diff :
------------------
	        <Following patch from Jeff Snyder>
	o [CRITICA] Release the proper region and not NULL pointer
	o [FEATURE] Fix messages

ir253_long_set_bit.diff :
-----------------------
	        <Following patch from Paul Mackerras>
	o [CORRECT] Argument of set_bit and friends should be unsigned long
		Should fix all compile warnings ;-)

ir253_lsap_cache_fix.diff :
-------------------------
	        <Following patch from Christoph Bartelmus, mangled by me>
	o [CORRECT] replace the global LSAP cache with LSAP caches private
		to each LAP.
		Fix a bug where two simultaneous connections from two devices
		using the same LSAPs would get mixed up.
		Should also improve performance in similar cases. 
