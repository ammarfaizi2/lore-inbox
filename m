Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbUJZJ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbUJZJ6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUJZJ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:58:31 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:59788 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S262179AbUJZJ62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:58:28 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <1098780150.2789.19.camel@laptop.fenrus.org>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026051100.GA5844@wotan.suse.de>  <417DEA8D.4080307@intel.com>
	 <1098780150.2789.19.camel@laptop.fenrus.org>
Date: Tue, 26 Oct 2004 10:57:54 +0100
Message-Id: <1098784674.3996.85.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space
	for suspend/resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 10:42 +0200, Arjan van de Ven wrote:
> On Tue, 2004-10-26 at 02:11 -0400, Len Brown wrote:
> > What this comes down to is that extended config space is device-specific.
> > Generic solutions will fail.  Only device drivers will work.
> > 
> > If there are no drivers for PCI bridges to properly save/restore
> > their config space, then should create them, even if this is all the 
> > drivers do.
> 
> note that by default, if there is no driver, the first 64 bytes of
> config space are saved/restored.

On one of my machines, doing this causes the cardbus bridge to explode
on resume (every other character of printks suddenly starts getting left
out, and then the machine hangs). This happens even if I've never loaded
the yenta driver. The naive approach certainly doesn't seem to be safe
on all hardware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

