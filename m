Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTGNAWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270469AbTGNAWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:22:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57798 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270467AbTGNAWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:22:50 -0400
Date: Sun, 13 Jul 2003 17:28:36 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713172836.5dd493f5.davem@redhat.com>
In-Reply-To: <52llv2vu06.fsf@topspin.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
	<20030713160200.571716cf.davem@redhat.com>
	<52llv2vu06.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2003 17:20:41 -0700
Roland Dreier <roland@topspin.com> wrote:

>     David> I didn't say I agree with all of Moguls ideas, just his
>     David> anti-TOE arguments.  For example, I also think RDMA sucks
>     David> too yet he thinks it's a good iea.
> 
> Sure, he talks about some weaknesses of TOE, but his conclusion is
> that the time has come for OS developers to start working on TCP
> offload (for storage).

The bad assumption here is that this belongs in the OS.

Let me ask you this, how many modern scsi drivers have to speak every
piece of the SCSI bus protocol.  Or fibre channel?  All of it is
done on the cards, and that is what I think the iSCSI people should
be doing instead of putting garbage into the OS.

And I've presented a solution to the problem at the OS level that
doesn't require broken things like TOE and RDMA yet arrives at
the same solution.

> But I also think Mogul is right: iSCSI HBAs are going to force OS
> designers to deal with TCP offload.

You don't need to offload TCP, it's the segmentation and checksuming
that has the high cost not the actual TCP logic in the operating
system.

RDMA and TOE both add unnecessary complications.  My solution requires
no protocol changes, just smart hardware which needs to be designed
for any of the presented ideas anyways.

