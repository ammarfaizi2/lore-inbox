Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbUDFUR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUDFUR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:17:58 -0400
Received: from p01m173.mxlogic.net ([66.179.109.173]:21397 "HELO
	p01m173.mxlogic.net") by vger.kernel.org with SMTP id S263985AbUDFUR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:17:56 -0400
Message-ID: <4072C371.CFA9CA1E@amis.com>
Date: Tue, 06 Apr 2004 08:49:21 -0600
From: Eric Whiting <ewhiting@amis.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MX-Spam: exempt
X-MX-MAIL-FROM: <ewhiting@amis.com>
X-MX-SOURCE-IP: [207.141.5.253]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> [***] non-PAE 4:4 kernels are being used too - there are a fair number
>       of users who run simulation code using 4GB of physical RAM and a
>       pure 4:4 kernel with no highmem features required. For these 4:4
>       users the overhead on number-crunching is even smaller, only
>       0.03%.

Ingo, 

What you describe above is a situation that matches our environment. 

We do have servers with more than 4G RAM that need PAE, but we have more
workstations with 4G (or 3G) of RAM that do not need PAE, but do need the 4:4
VM. In terms of a large simulation (> 3G of userspace VM) running to completion
-- a 3G RAM box with 4:4 VM is better than a 32G box with 3:1 VM -- even though
the box with 3G RAM may swap a little/lot.

4:4 is not the 'real' long term solution, but it will let us run more jobs on
32bit hardware until the x86_64 HW/SW support stabilizes a little more.  We
currently run jobs on solaris when single process VM requirement exceeds 4G. 

eric
