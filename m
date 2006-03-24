Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWCXTVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWCXTVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWCXTVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:21:39 -0500
Received: from mail.cs.umn.edu ([128.101.33.102]:35319 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S964795AbWCXTVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:21:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17444.18012.796603.193315@hound.rchland.ibm.com>
Date: Fri, 24 Mar 2006 13:19:56 -0600
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Dave C Boutcher <boutcher@cs.umn.edu>, Jeff Garzik <jeff@garzik.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
In-Reply-To: <442442CB.4090603@cs.wisc.edu>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	<4421D943.1090804@garzik.org>
	<1143202673.18986.5.camel@localhost.localdomain>
	<4423E853.1040707@garzik.org>
	<4423F60B.6020805@garzik.org>
	<1143207657.2882.65.camel@laptopd505.fenrus.org>
	<4423F91F.4060007@garzik.org>
	<17444.4455.240044.724257@hound.rchland.ibm.com>
	<442442CB.4090603@cs.wisc.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: boutcher@cs.umn.edu (Dave C Boutcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Christie wrote:
> Does the IBM vscsi code/SPEC follow the SRP SPEC or is it slightly 
> modified? We also have a SRP initiator in kernel now too. It is just not 
> in the drivers/scsi dir.

The goal was to follow the SRP spec 100%.  We added one other optional
command set (different protocol identifier than SRP) to exchange some
information like "who is at the other end", but the intent was that
the SRP part was right from the spec.

I think, since we implemented this in three operating systems (Linux,
AIX, and OS/400) using the T10 spec as the reference that we are probably
pretty close.

And yeah, I'm aware that there is another SRP implementation in the
kernel...Merging would be good...

Dave B
