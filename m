Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGaUiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGaUiS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGaUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:38:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47273 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262085AbUGaUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:38:16 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <1091297179.1677.290.camel@mindpipe>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <1091232770.1677.24.camel@mindpipe>
	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1091297179.1677.290.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091302522.6910.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 31 Jul 2004 20:35:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-07-31 at 19:06, Lee Revell wrote:
> Maybe we need a CONFIG_ANCIENT_HARDWARE that people can set if they want
> to use old stuff, and anywhere in the code we take a big hit to make
> some ancient device work wouldn't get compiled.  Devices could be added
> to this class as they are identified.

Wrong way around. You want a CONFIG_BOY_RACER option for people with
overclocked computers and delay loops "optimised" away.

If you want to speed this up then the two bits that the initial proposal
and Jeff have sensibly come up with are

1.	Are we doing too many probes
2.	Should we switch to proper reset polling

For certain cases (PPC spin up) we actually have switched to doing drive
spin up this way, I certainly have no objection to doing the rest of the
boot optimisation by following the standards carefully.

BTW: We should also turn on the PPC specific spin up stuff generically
nowdays with suspend/resume and stuff like LinuxBIOS.

Alan


