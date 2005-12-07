Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVLGWtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVLGWtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVLGWtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:49:22 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:3020 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030389AbVLGWtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:49:21 -0500
Date: Wed, 7 Dec 2005 22:48:58 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207224858.GA19285@srcf.ucam.org>
References: <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <20051207143337.GA16938@srcf.ucam.org> <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com> <1133970074.544.69.camel@localhost.localdomain> <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com> <1133918523.2936.12.camel@sli10-mobl.sh.intel.com> <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com> <1133994916.544.102.camel@localhost.localdomain> <20051207224323.GB3204@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207224323.GB3204@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:43:23PM +0100, Pavel Machek wrote:

> If someone swapped the drive while runtime, it would not be true, too,
> I guess. But that would be stupid thing to do. Swapping drive during
> suspend-to-RAM would be similary stupid. During suspend-to-disk, it
> might theoretically work, but we have big warnings saying "don't do
> that".

ACPI systems tend to fire ACPI notifications when a drive is ejected 
(and sometimes when you're preparing to eject them, depending on the 
system), which ought to make hotswap possible. I'm looking at 
integrating support for that into libata right now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
