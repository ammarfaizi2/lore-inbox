Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTEKSKz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTEKSKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:10:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:149
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261832AbTEKSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:10:54 -0400
Subject: Re: [PATCH] Use correct x86 reboot vector
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: CaT <cat@zip.com.au>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1bry9746i.fsf@frodo.biederman.org>
References: <20030510025634.GA31713@averell>
	 <20030510033504.GA1789@zip.com.au>
	 <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
	 <m1bry9746i.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052673863.29921.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 18:24:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 19:01, Eric W. Biederman wrote:
> > At least some SMP boxes freak if you do a poweroff request on CPU != 0
> 
> As per the MP spec.  The system should reboot on the bootstrap cpu.
> smp_processor_id() == 0 on x86.  apicid??

APM now makes its calls on CPU#0 which was the trigger for these
problems

