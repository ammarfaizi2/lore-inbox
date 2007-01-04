Return-Path: <linux-kernel-owner+w=401wt.eu-S932314AbXADHb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbXADHb7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXADHb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:31:59 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40173 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314AbXADHb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:31:59 -0500
Message-ID: <459CAD72.9060207@drzeus.cx>
Date: Thu, 04 Jan 2007 08:32:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: Alex Dubov <oakad@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
References: <459928F3.9010804@overt.org> <20070103150620.ac733abb.akpm@osdl.org> <459C8FA4.7080709@overt.org> <459C97A9.3060907@drzeus.cx> <459CA049.2080505@overt.org>
In-Reply-To: <459CA049.2080505@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Pierre Ossman wrote:
>   
>> Amen to that. All hw vendors that implement this particular form of
>> brain damage should be dragged out and shot.
>>
>> I'll fix a patch for this later on.
>>     
>
> See my updated Take 3 patch. I've implemented a uniqueness fix by
> adding additional RSP flags do make R6 and R7 unique. I don't know
> if this is what you wanted, but it works without being too ugly.
>
>   

NAK. If two response types look the same over the wire, then they should
have the same definition. Hardware that uses type codes is simply
broken. There are a lot of sinners unfortunately...

> However, also note my caveat that it's not clear if tifm or imxmmc
> can ever be made to work with SD 2.0 cards. *sigh*
>   

They probably can. They just need a fix for their switch statements.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

