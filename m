Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWAYJ21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWAYJ21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWAYJ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:28:27 -0500
Received: from mail.suse.de ([195.135.220.2]:39399 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751082AbWAYJ20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:28:26 -0500
Message-ID: <43D744B2.5030809@suse.de>
Date: Wed, 25 Jan 2006 10:28:18 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml: enable drivers (input, fb, vt)
References: <43D64F05.90302@suse.de> <20060124213141.GA7891@ccure.user-mode-linux.org>
In-Reply-To: <20060124213141.GA7891@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Tue, Jan 24, 2006 at 05:00:05PM +0100, Gerd Hoffmann wrote:
>> This patch enables a number of drivers for the uml build, in preparation
>> for the uml framebuffer driver patch coming next ;)
> 
> I'm still unsure about this.  It builds now, which is an improvement, but
> doesn't seem to work for me.
> 
> Displaying it remotely just doesn't work for me.  I get "uml-x11-fb:
> can't open X11 window" in the kernel log.

It wants create a shared memory segment for the framebuffer (using the
MIT-SHM extension), which works only with a local display ...

> Locally, it creates a window, and boots, but there's no output in the
> window, and there's no sign of a getty on the main console when I log
> in through another console.

Do you have "CONFIG_FRAMEBUFFER_CONSOLE=y" in .config?

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
