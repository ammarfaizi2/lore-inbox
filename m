Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTEHPYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTEHPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:24:25 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:54326 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S261727AbTEHPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:24:23 -0400
Subject: Re: Dell Inspiron 8200, 2.5.69, ACPI problems
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB9D625.1060704@blue-labs.org>
References: <3EB9D625.1060704@blue-labs.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052408205.1531.27.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 May 2003 11:36:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a 'me too' the same is true on inspiron 8500, under 2.4 and 2.5. 
I've got a fixed-up DSDT installed (see the guide at
http://www.cpqlinux.com/acpi-howto.html and
http://developer.intel.com/technology/iapc/acpi/bios_override.htm ..)
and that drops some of the noise (and fixes some of the missing bits)
but acpid and others (basically any acpi call) results in similar
messages.

Its not a kernel issue (well, its a warning from the kernel.. but the
kernel can't fix this directly.)  Turning off ACPI debugging will
probably make it stop, but the underlying issue is Dell (and many other
vendors) don't test their ACPI firmware under anything except windows.

>From Intel's ACPI site (and this applies to many acpi issues):
Q16. What is the "implicit return" issue, and why hasn't it been fixed?
A16. {cut} Due to an errata, this bug does not manifest itself on
Windows' ACPI implementations, and therefore was not detected when OEMs
tested their systems using that OS.
 
 We've made the decision for now to not be bug-for-bug compatible with
existing ACPI OS implementations. We are implementing according to the
ACPI specification's requirements, and hopefully this may drive better
compliance on all operating systems. 

On Wed, 2003-05-07 at 23:59, David Ford wrote:
> ACPI: AC Adapter [AC] (on-line)
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
> ACPI: Battery Slot [BAT0] (battery present)
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>         -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>         -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>         -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>     ACPI-0207: *** Warning: Buffer created with zero length in AML
>         -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Lid Switch [LID]
> ACPI: Power Button (CM) [PBTN]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
> ACPI: Thermal Zone [THM] (25 C)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Disconnect <lkml@sigkill.net>

