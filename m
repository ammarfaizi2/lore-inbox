Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVLGO6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVLGO6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVLGO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:58:19 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:42406 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751117AbVLGO6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:58:18 -0500
Date: Wed, 7 Dec 2005 14:58:11 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207145811.GA17119@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <20051207143337.GA16938@srcf.ucam.org> <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:45:19PM +0100, Bartlomiej Zolnierkiewicz wrote:

> OK, I understand it now - when using 'ide-generic' host driver for IDE
> PCI device, resume fails (for obvious reason - IDE PCI device is not
> re-configured) and this patch fixes it through using ACPI methods.

Unfortunately not - you get the same failure with piix (am I right in 
thinking that piix doesn't have any suspend/resume methods beyond the 
generic PCI ones? I'm afraid I don't have enough knowledge of the IDE 
layer to know if there's some other magic that calls an ide-specific 
resume function in it...)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
