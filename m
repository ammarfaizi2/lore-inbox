Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267630AbUBRR2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267623AbUBRR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:27:55 -0500
Received: from 221.80-203-45.nextgentel.com ([80.203.45.221]:12095 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267618AbUBRR1s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:27:48 -0500
Subject: Re: 2.6.2 ACPI problem
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@vision.ee>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <4028EBC3.6090002@vision.ee>
References: <4028EBC3.6090002@vision.ee>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1077108844.7141.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.4 
Date: Wed, 18 Feb 2004 13:54:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 10.02.2004 kl. 16.33 +0200, skrev Lenar Lõhmus:

> Hi,
> 
> Having problems here with ACPI on Compaq Evo N610c laptop.
> Everything boots up fine except when loading battery module
> one gets this:
> 
>     ACPI-1120: *** Error: Method execution failed 
> [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed 
> [\_SB_.C045.C059.C0E2.C14E] (Node c157bc40), AE_AML_UNINITIALIZED_LOCAL
>     ACPI-1120: *** Error: Method execution failed [\_SB_.C198._BTP] 
> (Node c1577d20), AE_AML_UNINITIALIZED_LOCAL
> ACPI: Battery Slot [C198] (battery present)
> ACPI: Battery Slot [C199] (battery absent)
> 
Seeing this exact same output on a N600c laptop here.

> Tried with and without RELAXED_AML.
> 
> Now despite this machine seems to work fine until kde's laptop daemon 
> does something I'm not aware of which results in
> these lines in dmesg:
> 
> Feb 10 17:52:35 debian kernel:     ACPI-0245: *** Error: Cannot release 
> Mutex [_GL_], not acquired
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C045.C059.C0E2.C12C] (Node c157bf80), 
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C045.C059.C0E2.C13F] (Node c157bd40), 
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C045.C059.C0E2.C145] (Node c157bcc0), 
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C045.C059.C0E2.C14C] (Node c157bc60), 
> AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C14C] (Node c1577ee0), AE_AML_MUTEX_NOT_ACQUIRED
> Feb 10 17:52:35 debian kernel:     ACPI-1120: *** Error: Method 
> execution failed [\_SB_.C198._BST] (Node c1577da0), 
> AE_AML_MUTEX_NOT_ACQUIRED
> 
I also saw these with GNOME until the battery status applet was fixed.

See http://bugzilla.gnome.org/show_bug.cgi?id=129167 for the relevant
fix for battstat. Maybe this fix shows a similar fix is possible under
KDE? Not sure this is a fix really, but at least the symptoms went away
for me after this got fixed.

Cheers
Kjartan
