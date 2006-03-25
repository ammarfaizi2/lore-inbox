Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWCYAc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWCYAc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCYAc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:32:26 -0500
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:394 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751187AbWCYAcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:32:24 -0500
To: boutcher@cs.umn.edu
Cc: michaelc@cs.wisc.edu, jeff@garzik.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, m+Ian.Pratt@cl.cam.ac.uk, aliguori@us.ibm.com,
       chrisw@sous-sol.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       ian.pratt@xensource.com, ian.pratt@cl.cam.ac.uk,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <17444.18012.796603.193315@hound.rchland.ibm.com>
References: <17444.4455.240044.724257@hound.rchland.ibm.com>
	<442442CB.4090603@cs.wisc.edu>
	<17444.18012.796603.193315@hound.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060325093218K.fujita.tomonori@lab.ntt.co.jp>
Date: Sat, 25 Mar 2006 09:32:18 +0900
X-Dispatcher: imput version 20040704(IM147)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: boutcher@cs.umn.edu (Dave C Boutcher)
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
Date: Fri, 24 Mar 2006 13:19:56 -0600

> 
> Mike Christie wrote:
> > Does the IBM vscsi code/SPEC follow the SRP SPEC or is it slightly 
> > modified? We also have a SRP initiator in kernel now too. It is just not 
> > in the drivers/scsi dir.
> 
> The goal was to follow the SRP spec 100%.  We added one other optional
> command set (different protocol identifier than SRP) to exchange some
> information like "who is at the other end", but the intent was that
> the SRP part was right from the spec.
> 
> I think, since we implemented this in three operating systems (Linux,
> AIX, and OS/400) using the T10 spec as the reference that we are probably
> pretty close.

About the target side, the lun structure is very different the spec
(tgt implements this as a user-space library).


> And yeah, I'm aware that there is another SRP implementation in the
> kernel...Merging would be good...

Do you have any plans for this?

I've been thinking about writing something like scsi_transport_srp,
which can help the initiator and target drivers. I like to enable tgt
to support RDMA-capable adapters.
