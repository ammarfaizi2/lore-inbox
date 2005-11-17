Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVKQOCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVKQOCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVKQOCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:02:20 -0500
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:45967
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S1750844AbVKQOCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:02:18 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <437C8D67.2030806@eyal.emu.id.au>
Date: Fri, 18 Nov 2005 01:02:15 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hware clock left bad after a system failure
References: <437B3C62.2090803@eyal.emu.id.au> <Pine.LNX.4.61.0511161037130.12055@chaos.analogic.com> <437BAA0E.2020602@eyal.emu.id.au> <Pine.LNX.4.61.0511170822590.7964@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511170822590.7964@chaos.analogic.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 16 Nov 2005, Eyal Lebedinsky wrote:
[report of hwclock breakage trimmed]
> 
> If your machine was being heavily swapped when the disk problems
> occurred, this __might__ explain the corruption. However, I would
> first check RAM, do not overclock, etc. It might be that bad
> RAM, in fact, is the reason for all your problems and you don't
> really have disk or driver problems at all.

I will now keep watching for q while quietly. Earlier today I had
another such hard lockup, identical errors claiming a disk failure.

This time I went into the BIOS on bootup and the clock was set
correctly. Good. Booted and it did the usual fscks but then dropped
into a shell when errors were found on /. I did the necessary fscks.

On a hunch I did 'date' and the clock was 11h ahead (we actually
are +11 now). So the problem is during the boot, not during the
crash. I consider that the boot thinks that I am running a UTC
hwclock and adjusts for this, when in fact I run a local time
hwclock. There must be something in the scripts that goes funny
if / does an fsck and then drops into the recovery shell.

I will start looking in this direction.

This is Debian Sarge in x86.

Thanks

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
