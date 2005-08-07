Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbVHGNpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbVHGNpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 09:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbVHGNpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 09:45:07 -0400
Received: from tim.rpsys.net ([194.106.48.114]:18144 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751765AbVHGNpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 09:45:06 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.62.0508050817060.28659@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508031716001.24733@graphe.net>
	 <1123154825.8987.33.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508040703300.3277@graphe.net>
	 <1123166252.8987.50.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508050817060.28659@graphe.net>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 14:44:35 +0100
Message-Id: <1123422275.7800.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 08:17 -0700, Christoph Lameter wrote:
> On Thu, 4 Aug 2005, Richard Purdie wrote:
> > 
> > We know the the failure case can be identified by the
> > cmpxchg_fail_flag_update condition being met. Can you provide me with a
> > patch to dump useful debugging information when that occurs?
> 
> Well yes simply print out the information available in that context.
> 
> +		printk(KERN_CRIT "cmpxchg fail mm=%p vma=%p addr=%lx write=%d ptep=%p pmd=%p entry=%lx new=%lx\n",
> +				mm, vma, address, write_access, pte, pmd, pte_val(entry), pte_val(new_entry));

Ok, this results in an infinite loop of one message with no change to
the numbers:

cmpxchg fail mm=c3455ae0 vma=c355517c addr=4025f000 write=2048
ptep=c2f0597c pmd=c2b79008 entry=88000f7 new=8800077

Richard

