Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVCCLN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVCCLN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCCLN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:13:29 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37546
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261589AbVCCLBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:01:45 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com,
       Linus Torvalds <torvalds@osdl.org>, rmk+lkml@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303021506.137ce222.akpm@osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
	 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	 <20050303002047.GA10434@kroah.com>
	 <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	 <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com>
	 <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com>
	 <20050303021506.137ce222.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 12:01:42 +0100
Message-Id: <1109847703.4370.38.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 02:15 -0800, Andrew Morton wrote:
> If we were to get serious with maintenance of 2.6.x.y streams then that is
> a 100% productisation activity.  It's a very useful activity, and there is
> demand for it.

Correct. That's what -ac and -as kernels try to achieve. Moving those
activities into 2.6.x.y would be easier to understand for users.

> But it is a very different activity.  And a lot of this
> discussion has been getting these two activities confused.

Ack.

> Many people on this mailing list want a super-stable kernel as their first
> (and sometimes only) priority (the product group).  But others have other
> requirements: to make their code avaialble, or to get their hardware
> supported, or to fix that scalability problem (the technology group).  The
> product group's interests are in conflict with the technology group's. 
> 
> There will be no solution to this problem which is completely satisfactory
> to either party.

Right, but moving to the even/odd scheme is worse. Even versions will be
ignored within no time like the -rc versions are now. The result will be
that the "stable" odd releases will be less frequent and the -rc phase
of those will be as hard to sell to testers as the current ones. We will
end up with 2.6.ODD in the same shape as we do now with 2.6.x releases.

Moving to a -preX / rcX scheme might help to convince users to give the
-rc versions a try and help to stabilze for the real release.

What about:
2.6-mm	
2.6-devel
2.6.x-stable

-mm 	bleeding edge
-devel	stabilized from -mm and subsystems
-stable stabilized from devel and real bugfixes

In this case the current -rc scheme could work in a real "release
candidate" scheme. 

The devel tree would not be bound to release cycles and would just
contain ongoing development, so the held back pile of changes is not
growing up in the way it does now.

tglx


