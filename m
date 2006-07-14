Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWGNJkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWGNJkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWGNJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:40:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55508 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161007AbWGNJjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:39:52 -0400
Subject: Re: [patch, take 3] PCI: use ACPI to verify extended config space
	on x86
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, "Brown, Len" <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200607140336_MC3-1-C4F8-374F@compuserve.com>
References: <200607140336_MC3-1-C4F8-374F@compuserve.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 11:39:48 +0200
Message-Id: <1152869988.3159.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 03:34 -0400, Chuck Ebbert wrote:
> From: Rajesh Shah <rajesh.shah@intel.com>
> 
> Extend the verification for PCI-X/PCI-Express extended config
> space pointer. Checks whether the MCFG address range is listed
> as a motherboard resource, per the PCI firmware spec.

I'm still not quite happy about this; the entire point of the check is
that we CAN'T trust the ACPI implementation, and want a second opinion.
This patch basically asks the ACPI implementation if we can trust the
ACPI implementation. I'm not sure that's a good idea.
And I understood that most issues went away with the more relaxed check
that is in gregkh's tree already (if not in mainline, I should check
that). 

