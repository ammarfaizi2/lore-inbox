Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWA1Bbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWA1Bbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWA1Bbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:31:43 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:58254 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1422692AbWA1Bbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:31:42 -0500
Date: Sat, 28 Jan 2006 01:31:11 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Luca <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128013111.GA30225@srcf.ucam.org>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127232207.GB1617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127232207.GB1617@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 12:22:07AM +0100, Pavel Machek wrote:

> If vbetool's primary purpose is to fix video after suspend/resume,
> then perhaps right thing to do is to integrate it into s2ram and
> maintain it there.

That's the primary purpose, though there's a couple of edge cases. 
For VBE state saving/restoring, it seems to be important to save the 
state before X has started rather than doing so at suspend time - some 
i855 systems break otherwise.

Not strictly related - Pavel, try taking a look at the acpi-support 
package in http://archive.ubuntu.com/ubuntu/pool/main/a/acpi-support/ . 
There's a large list of witelisted hardware there. OSDL recently set up 
a mailing list (desktop-portables@lists.osdl.org) for cross-distribution 
laptop discussion. It would probably be helpful to discuss working 
machines there, rather than duplicate the whitelisting efforts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
