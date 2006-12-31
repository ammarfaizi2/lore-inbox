Return-Path: <linux-kernel-owner+w=401wt.eu-S933144AbWLaMFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144AbWLaMFd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933145AbWLaMFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:05:33 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40014 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933144AbWLaMFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:05:33 -0500
Message-ID: <4597A791.60007@drzeus.cx>
Date: Sun, 31 Dec 2006 13:05:37 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: linux@youmustbejoking.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc2] Add a quirk to allow at least some ENE PCI
 SD card readers to work again
References: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Salt wrote:
> Add a quirk to allow at least some ENE PCI SD card readers to work again
> 
> Support for these devices was broken for 2.6.18-rc1 and later by commit
> 146ad66eac836c0b976c98f428d73e1f6a75270d, which added voltage level support.
> 
> This restores the previous behaviour for these devices (PCI ID 1524:0550).
> 
> Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
> 

Oh? If this is the source of problems for ENE controllers then this is indeed a magnificent find. Good work.

I'd like to know a little more about it though:

- Exactly what errors where you seeing without this patch?

- The patch effectively sets only the highest power. Have you tried other bit combinations to figure out if all of these are really needed?

  (This also means that the current patch is broken as the limited voltage range needs to also be reported to the MMC layer).

- Could you change the patch so that it covers all ENE controllers and send it out for testing on sdhci-devel? That way we could see if there are any more ENE controllers that will benefit from this
quirk. Just remember to ask people for a lspci.

Again, very good work.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
