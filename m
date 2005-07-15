Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVGOKzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVGOKzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGOKyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:54:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15328 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262456AbVGOKwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:52:37 -0400
Date: Fri, 15 Jul 2005 12:51:49 +0200 (MEST)
Message-Id: <200507151051.j6FApn0N003458@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: len.brown@intel.com, luming.yu@intel.com
Subject: RE: 2.6.13-rc3 ACPI regression and hang on x86-64
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005 15:23:52 -0400, Brown, Len wrote:
>>acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail
>>
>>on the console, and then the machine is hung hard.
>
>2.6.13-rc3 x86_64 failed, but 
>2.6.13-rc2 x86_64 worked
>
>And both of these revisions in the i386 kernel still work?

With the i386 kernel, 2.6.13-rc2 works perfectly.
With the i386 kernel, 2.6.13-rc3 mostly works, but
it fails to detect the CPU's C2 state.

>Is it possible for you to test the latest ACPI patch?
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
>2.6.13/

I was going to, but as it was for -rc2 not -rc3 I decided to
try Venkatesh Pallipadi's C-state FADT regression patch first.
<http://marc.theaimsgroup.com/?l=linux-kernel&m=112135903100520&w=2>
Success! That solved all my ACPI issues with -rc3.

"Yu, Luming" wrote:
>> on the console, and then the machine is hung hard.
>If you didn't press that key,   the machine still hung?

No it worked except for having no power management and an
unusable console due to ACPI having reduced the brightness.

/Mikael
