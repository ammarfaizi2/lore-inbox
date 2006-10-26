Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423450AbWJZHUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423450AbWJZHUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 03:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWJZHUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 03:20:20 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:37522 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751760AbWJZHUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 03:20:19 -0400
Message-ID: <454061B0.3060907@drzeus.cx>
Date: Thu, 26 Oct 2006 09:20:16 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Timo Teras <timo.teras@solidboot.com>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Poll card status after rescanning cards
References: <20061016090609.GB17596@mail.solidboot.com> <453B4005.8080501@drzeus.cx> <20061024101458.GA17024@mail.solidboot.com> <453E4654.1030809@drzeus.cx> <20061025063741.GA18599@mail.solidboot.com>
In-Reply-To: <20061025063741.GA18599@mail.solidboot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Teras wrote:
> Some broken cards seem to process CMD1 even in stand-by state. The result is
> that the card replies with ILLEGAL_COMMAND error for the next command sent
> after rescanning. Currently the next command is select card, which would
> return the error. But CMD7 does actually succeed and retries of the command
> will timeout. The workaround is to poll card status after CMD1 to clear the
> pending error.
>
> Signed-off-by: Timo Teras <timo.teras@solidboot.com>
>   

Thanks, queued up for -mm.

Andrew, this replaces a patch in your set, so you probably need to
remove that before your next pull from me.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

