Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWKBCaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWKBCaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 21:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWKBCaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 21:30:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:35337 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750956AbWKBCaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 21:30:16 -0500
Message-ID: <454957F3.3020707@shadowen.org>
Date: Thu, 02 Nov 2006 02:29:07 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Len Brown <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work
References: <20061029160002.29bb2ea1.akpm@osdl.org>	<200610310829.31554.rjw@sisk.pl>	<20061030234008.51da7d9a.akpm@osdl.org>	<200610310848.02739.rjw@sisk.pl> <20061030235850.cb3a40ed.akpm@osdl.org>
In-Reply-To: <20061030235850.cb3a40ed.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 31 Oct 2006 08:48:01 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>>>> It's one of these:
>>>>
>>>> git-acpi.patch
>>>> git-acpi-fixup.patch
>>>> git-acpi-more-build-fixes.patch
>>>>
>>> You might need to resend the original report so the acpi guys can see it.
>> Okay, I will.
> 
> Thanks.
> 
>>> Meanwhile, I'll have to drop the acpi tree.
>> Well, I'd prefer to find the offending commit within the tree, as the majority
>> of changes look pretty innocent.  Are the commits available somewhere as
>> individual patches?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test
> 
> I've not had much success persuading git to emit a series of applyable
> patches.

git-format-patch can make a patch file for each commit in range, each
prefixed with a four digit patch number and named similarly to patches
in -mm:

    git format-patch -o <dir> <from>..<to>

For example:

    0009-DM-kill-bogus-uninit-warning.txt
    0010-drivers-net-drivers-net-Silence-more-bogosities.txt
    0011-debug-shared-irqs.txt
    0012-debug-shared-irqs-kconfig-fix.txt
    0013-make-frame_pointer-default-y.txt

It can also produce an mbox mailbox:

    git format-patch --stdout <from>..<to>

I've used this second form in combination with a 'mailbomb' exploder to
extract the patches with a series file.

-apw
