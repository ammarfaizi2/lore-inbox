Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTEZRHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEZRHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:07:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:3477 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261798AbTEZRHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:07:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 26 May 2003 10:20:18 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x 
In-Reply-To: <3ED21CE3.9060400@winischhofer.net>
Message-ID: <Pine.LNX.4.55.0305261006420.2419@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, Thomas Winischhofer wrote:

>
> How many samples of the SiS650 did you have for testing?

Only the following ...


> -) a M650 (host bridge ID 1039:0650, rev 11),
>     with ISA bridge (1039:0008) revision 0x04, and

Can you send me a "lscpi -vxxx" of this machine ?



> and I had (and have) no problems with irqs or USB (or anything) on any
> of these machines.
>
> Are you sure that checking the revision number of the device is enough?
>
> Are you aware of the fact that SiS only produces the chips but never the
> mainboards, and that SiS chips are in a 1000 ways "customizible" which
> not in a single case I came accross so far was detectable by the device
> revision number?

Well, it can't get easier than that. My machine (CPQ Presario 3045US)
issues router requests for 0x60...0x63 for the 3 OHCI and 1 EHCI, and
without the patch USB does not come up not even if you start crying like a
baby. The patch also add the "stdroute" thingy that will enable future
cases like mine, to boot the kernel without requiring any other patches
(at least for pass thru router requests like the one I'm seeing here).



- Davide

