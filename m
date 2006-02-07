Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWBGEJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWBGEJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 23:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWBGEJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 23:09:43 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:50315 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964891AbWBGEJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 23:09:43 -0500
Date: Tue, 7 Feb 2006 04:09:35 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Michael E Brown <michael_e_brown@Dell.com>
Cc: Andrew Morton <akpm@osdl.org>, matt_domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060207040935.GA25853@srcf.ucam.org>
References: <1139283796.28567.179.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139283796.28567.179.camel@soltek.michaels-house.net>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 09:43:16PM -0600, Michael E Brown wrote:

> 	I would _strongly_ suggest that this patch _not_ go in. This driver
> uses hardcoded values that are subject to change without notice. It is
> perfectly legitimate for future versions of Dell BIOS to interpret pokes
> to cmos location 0x99 as the command to format your hard drive.

I managed to send the wrong patch - the Dell one only reads from nvram. 
If nvram reads are likely to reformat your hard drive, I think Dell 
needs to reconsider its BIOS design :)

More seriously, a quick scan of libsmbios hasn't revealed any method for 
obtaining the screen brightness. It's possible that I'm blind (I'm 
certainly slightly drunk), but can you give a pointer to the correct 
mechanism for making this call?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
