Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286654AbRLVDff>; Fri, 21 Dec 2001 22:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286657AbRLVDf0>; Fri, 21 Dec 2001 22:35:26 -0500
Received: from sushi.toad.net ([162.33.130.105]:131 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S286654AbRLVDfW>;
	Fri, 21 Dec 2001 22:35:22 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Andreas Steinmetz <ast@domdv.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Dec 2001 22:35:29 -0500
Message-Id: <1008992132.805.6.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
---------------------------------------------------------------------
Here is an updated list of the patches:
1. Notify listener of suspend before drivers        (Russell King, me)
    (appended)
2. Fix idle handling                                (Andreas Steinmetz)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
3. Control apm idle calling by runtime parameter    (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2
4. Detect failure to stop CPU on apm idle call      (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100869841008117&w=2
---------------------------------------------------------------------

I have just tried to combine these and I have run into trouble.
Patch 4 applies on top of patch 3, but neither of these applies
on top of patch 2.  Can you guys sort these out into one big
"fix idle calling" patch that includes a runtime parameter
to control idle calling, which overrides a default selected
either by CONFIG_APM_CPU_IDLE or by a bit of code that checks
for CPU stoppage?

Or has someone already done this?

The latest Russell King (modified by me) patch is now at:
   http://panopticon.csustan.edu/thood/apm.html

--
Thomas Hood


