Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUK1WiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUK1WiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUK1WiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:38:23 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:27062 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261203AbUK1WiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:38:20 -0500
Subject: Re: Suspend 2 merge: 19/51: Remove MTRR sysdev support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125182250.GI1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295453.5805.263.camel@desktop.cunninghams>
	 <20041125182250.GI1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101680114.4343.288.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 09:34:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 05:22, Pavel Machek wrote:
> Hi!
> 
> > This patch removes sysdev support for MTRRs (potential SMP hang and
> > shouldn't be done with interrupts done anyway). Instead, we save and
> > restore MTRRs when entering and exiting the processor freezers (ie when
> > saving the registers & context for each CPU via an SMP call).
> 
> This will break acpi s3...

MTRR support is via sysdev is by design broken (SMP deadlock possible),
so you need to add it to the right place in your S3 code. (ie, it's not
that I'm breaking S3. It's already broken, but works while you only
support suspending !SMP).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

