Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTFGFVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 01:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFGFVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 01:21:24 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:38827 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262569AbTFGFVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 01:21:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrey Klochko <andrey@morgon.mae.cornell.edu>
Date: Sat, 7 Jun 2003 15:33:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.31014.94516.422433@gargle.gargle.HOWL>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Add module_kernel_thread for threads that live in modules.
In-Reply-To: message from Andrey Klochko on Thursday June 5
References: <E19NkWO-0005i0-00@notabene.cse.unsw.edu.au>
	<20030605105016.A9587@morgon.mae.cornell.edu>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 5, andrey@morgon.mae.cornell.edu wrote:
> >  
> > -	/* Release module */
> > -	unlock_kernel();
> 
> You've locked the kernel and didn't unlock it.
>  

This was just before the thread exited.  When a thread exits it
automatically drops the kernel lock anyway.  It seemed un-necessary to
explicitly unlock it aswell.

NeilBrown
