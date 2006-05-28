Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWE1QvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWE1QvR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWE1QvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:51:17 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:25095 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750798AbWE1QvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:51:17 -0400
Message-ID: <4479D500.2060305@superbug.co.uk>
Date: Sun, 28 May 2006 17:51:12 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] 2.6.17rc emu10k1 regression.
References: <20060528164015.GA13499@redhat.com>
In-Reply-To: <20060528164015.GA13499@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> $ lspci  | grep audio
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> 06:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
> 
> (That's 06:0d.1 0980: 1102:7002 (rev 01))
> 
> This worked fine in 2.6.16, however when I try a .17rc kernel I get this..
> 
> cannot find the slot for index 0 (range 0-1)
> EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12
> 
> (Unremarkable, considering it *isn't* an Audigy)
> 
> 

The same driver is used for the EMU10K1 and the Prodigy.
the -12 is an "Out of memory", so something outside the alas driver tree
must have changed to cause this problem.

James
