Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVFFOyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVFFOyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFFOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:54:47 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:31931 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261399AbVFFOyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:54:45 -0400
Date: Mon, 6 Jun 2005 15:54:29 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Message-ID: <20050606145429.GA18396@srcf.ucam.org>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine> <200506051732.08854.stefandoesinger@gmx.at> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine> <20050606144501.GB2243@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606144501.GB2243@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 04:45:01PM +0200, Pavel Machek wrote:

> NULL pointer dereference in filp_open; whats that strange about it?
> Use printks to debug this one, nothing mysterious.

I can't see any way that a null pointer could get to filp_open without 
something already being very wrong - the kernel worked fine before 
suspend. Unfortunately, that's the one occasion that we've got the 
machine (an HP nc4000) to resume. Since then, it simply freezes before 
hitting "Back to C" despite having had no kernel or configuration 
changes. The behaviour is very non-deterministic, which makes me wonder 
about something in the suspend or resume process damaging state.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
