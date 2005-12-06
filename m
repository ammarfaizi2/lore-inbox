Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVLFWU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVLFWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLFWU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:20:26 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:14228 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965042AbVLFWUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:20:24 -0500
Date: Tue, 6 Dec 2005 22:20:02 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
       akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051206222001.GA14171@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:10:04PM +0800, Shaohua Li wrote:

> TODO: invoking ATA commands.
> 
> Though we didn't invoke ATA commands, this patch fixes the bug at 
> http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> actually fixes a lot of systems in his test.
> I'm not familiar with IDE, so comments/suggestions are welcome.

Of the DSDTs I've looked at, most seem to provide taskfile commands 
concerned about doing things like setting up drive security. I haven't 
yet seen an IDE failure on resume when using this patch, so the _GTF 
stuff doesn't seem terribly important. The reason for it not currently 
being implemented is that the IDE queues haven't been restarted at the 
point where this code is called, so there's no obvious way of submitting 
them to the drive yet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
