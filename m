Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKOWps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKOWps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUKOWnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:43:43 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39215 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261493AbUKOWnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:43:02 -0500
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <419914F9.7050509@techsource.com> <52is86lqur.fsf@topspin.com>
	<41992C5C.9060201@techsource.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 15 Nov 2004 14:42:55 -0800
In-Reply-To: <41992C5C.9060201@techsource.com> (Timothy Miller's message of
 "Mon, 15 Nov 2004 17:23:24 -0500")
Message-ID: <521xeulonk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Nov 2004 22:43:01.0297 (UTC) FILETIME=[762BDA10:01C4CB64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the audio device:

    > 0000:00:1f.5 Class 0401: 8086:2445 (rev 04)

and it looks like sound/pci/intel8x0.c should support it:

static struct pci_device_id snd_intel8x0_ids[] = {
	/* ... */
	{ 0x8086, 0x2445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 82801BA */

What happens when you load snd_intel8x0?

 - Roland
