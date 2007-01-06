Return-Path: <linux-kernel-owner+w=401wt.eu-S1751393AbXAFNfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXAFNfq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbXAFNfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:35:45 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40272 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbXAFNfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:35:45 -0500
Message-ID: <459FA5B5.8060402@drzeus.cx>
Date: Sat, 06 Jan 2007 14:35:49 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V9: mmc_sysfs.diff
References: <4582F007.7030100@indt.org.br> <459B9C4E.3020406@indt.org.br>
In-Reply-To: <459B9C4E.3020406@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> Hi all,
>
> I believe this code is following the latest Russel's comments.
>   

Afraid not. mmc_card_claim_host() is incredibly unintuitive in that it
requires an unlock on error (the lock always succeeds, the card select
might fail). I'll fix that up and commit the patch set.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

