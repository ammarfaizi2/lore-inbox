Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKRNsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTKRNmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:44 -0500
Received: from ns.suse.de ([195.135.220.2]:1234 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262746AbTKRNmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:19 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: kl@vsen.dk, linux-kernel@vger.kernel.org
Subject: Re: [Bug 1428] New: 3c59x won't work at all with 2.6.0-test	kernels
References: <600810000.1067231679@[10.10.2.4].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Oct 2003 16:24:16 +0100
In-Reply-To: <600810000.1067231679@[10.10.2.4].suse.lists.linux.kernel>
Message-ID: <p73fzheaelb.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> http://bugme.osdl.org/show_bug.cgi?id=1428
> 
>            Summary: 3c59x won't work at all with 2.6.0-test kernels.
>     Kernel Version: 2.6.0-test4-mmX to 2.6.0-test8-mm1
>             Status: NEW
>           Severity: blocking

Does not deserve a blocking.

>              Owner: jgarzik@pobox.com
>          Submitter: kl@vsen.dk
> 
> 
> Distribution: Gentoo Linux
> Hardware Environment: IBM Thinkpad X20 - miniPCI 3com network:
> lspci with 2.4.22 kernel:
>  00:0a.0 Ethernet controller: 3Com Corporation 3c556B Hurricane CardBus (rev 20)
> 
> Software Environment:
> glibc-2.3.2, gcc-3.2.3 - anything else? 
> Problem Description:
> My 3c59x miniPci network card won't work at all with 2.6.0-test kernels.I think
> I've seen it work once, with an old 2.6.0-test kernel, but I'm not sure, and
> I've tried all the way back to 2.6.0-test3, and can't reproduce it (working that
> is).
> the Hardware mac address is set to all FF's on 2.60. ifconfig works fine - I
> just can't ping anything.
> 
> with 2.4.22 it all works like a charm.
> 
> Steps to reproduce:
> compile 2.6.0-testX with 3c59x as module or built-in.

3c59x works fine for me in 2.6.0test9

Most likely the user has some problems with interrupt routing.
I would try with pci=noacpi or acpi=off or disable IO-APIC support.

-Andi

