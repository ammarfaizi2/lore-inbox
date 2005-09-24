Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVIXE2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVIXE2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVIXE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 00:28:20 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:44041 "HELO
	wb2-a.mail.utexas.edu") by vger.kernel.org with SMTP
	id S1751403AbVIXE2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 00:28:20 -0400
Message-ID: <4334D5E1.5050309@mail.utexas.edu>
Date: Fri, 23 Sep 2005 21:28:17 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
User-Agent: Thunderbird 1.6a1 (X11/20050918)
MIME-Version: 1.0
To: axboe@suse.de, jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bad news regarding sata suspend/resume, thought it may not
specifically be a problem with the patch but something more
fundamental.

I have a tecra M3 which uses the i915m and ich6m chips and
as such should be very similar to various dells and ibms which
this patch works great on.

However, for my particular machine, the step of putting the
sata controller pci device into D3 locks the machine up
completely. If I skip this part of the suspend process, it
doesn't lock up. but something is clearly not right with it
as the hd will fail to wake up if I leave it suspended too
long (if it's suspended and then quickly resumed like this,
it seems to work). Putting the PCI device into D1 leads to
problems after resume regardless of the amount of time
suspended.

I disassembled the acpi DSDT and checked it for errors but
didn't find anything of note, so I'm not sure why it does
this. It's obviously not a fundamental problem because windows
can suspend fine on it, but there's clearly a piece of the
puzzle missing. It's all very frustrating because this is
the only part of the machine that can't handle suspending yet.

I tried the reformatted patch with and without Jens' workaround
but the behavour is unchanged.

--phil
