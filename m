Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752268AbWKQSWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbWKQSWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbWKQSWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:22:33 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29117 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1752129AbWKQSWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:22:33 -0500
Date: Fri, 17 Nov 2006 19:05:28 +0100 (MET)
Message-Id: <200611171805.kAHI5S3C025845@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: ak@suse.de, mikpe@it.uu.se
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Cc: akpm@osdl.org, arvidjaar@mail.ru, bunk@stusta.de, discuss@x86-64.org,
       earny@net4u.de, ebiederm@xmission.com, gregkh@suse.de,
       jens.axboe@oracle.com, komurojun-mbn@nifty.com, len.brown@intel.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-usb-devel@lists.sourceforge.net, maan@systemlinux.org,
       mingo@redhat.com, oprofile-list@lists.sourceforge.net,
       phil.el@wanadoo.fr, prakash@punnoor.de, romosan@sycorax.lbl.gov,
       shemminger@osdl.org, stern@rowland.harvard.edu, torvalds@osdl.org,
       wcohen@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 11:29:25 +0100, Andi Kleen wrote:
>On Friday 17 November 2006 10:59, Mikael Pettersson wrote:
>
>> It certainly worked when I originally implemented it. 
>
>I don't think so. NMI watchdog never recovered no matter if oprofile
>used the counter or not.

If so then that's a bug in oprofile or the x86-64 kernel.
I just checked the 2.6.18 i386 kernel + the perfctr kernel
extension, and the NMI watchdog did start ticking again when
perfctr called release_lapic_nmi().

Before the {reserve,release}_lapic_nmi() API went into the
kernel the NMI watchdog might not have resumed, but that was
ages ago (the 2.6.6 kernel).

/Mikael
