Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbULRReI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbULRReI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULRReI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:34:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:18580 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261182AbULRReF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:34:05 -0500
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1103389648.5967.7.camel@gaston>
References: <1103389648.5967.7.camel@gaston>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 18:33:58 +0100
Message-Id: <1103391238.5775.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-18 at 18:07 +0100, Benjamin Herrenschmidt wrote:
> Hi Takashi !
> 
> I get that regulary with latest kernel when using Alsa. Can't tell if it's new
> as I used dmasound so far, just wanted to give Alsa a try...

It seems to be related to oss emulation I'd say ... it's triggered by
gtkpbbuttons volume control keys, which will open/ioctl/write/close the
device very quicky (changing volume & outputing a beep)

Maybe a race ? This is a laptop, so UP, no PREEMPT.

Ben.


