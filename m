Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIJUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIJUeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIJUeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:34:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:6834 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267767AbUIJUeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:34:22 -0400
Subject: Re: [PATCH] BSD Jail LSM (2/3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <1094847787.2188.101.camel@serge.austin.ibm.com>
References: <1094847705.2188.94.camel@serge.austin.ibm.com>
	 <1094847787.2188.101.camel@serge.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094844708.18107.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 20:31:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 21:23, Serge Hallyn wrote:
> Attached is a patch against the security Kconfig and Makefile to support
> bsdjail, as well as the bsdjail.c file itself.  bsdjail offers
> functionality similar to (but more limited than) the vserver patch.

Looking over the code the first question I would ask is that it supports
AF_INET but not AF_INET6. That seems a bit limited in todays internet
environment. 

> A process in a jail lives under a chroot which is not vulnerable to the
> well-known chdir(...)(etc)chroot(.) attack against normal chroots, and
> may be locked to one ip address.  For additional features, please see
> Documentation/bsdjail.txt, which is included in the next patch.

You can break out with someone co-operating from outside the jail but
that I guess is pretty harmless anyway. 

Alan
