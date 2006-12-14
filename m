Return-Path: <linux-kernel-owner+w=401wt.eu-S1751839AbWLNKNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWLNKNJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWLNKNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:13:09 -0500
Received: from www.osadl.org ([213.239.205.134]:56223 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751839AbWLNKNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:13:08 -0500
X-Greylist: delayed 1018 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 05:13:08 EST
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 11:13:04 +0100
User-Agent: KMail/1.9.5
References: <20061213195226.GA6736@kroah.com> <1166044547.27217.902.camel@laptopd505.fenrus.org> <20061214093028.GF6674@rhun.haifa.ibm.com>
In-Reply-To: <20061214093028.GF6674@rhun.haifa.ibm.com>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141113.05009.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 10:30 schrieb Muli Ben-Yehuda:
> On Wed, Dec 13, 2006 at 10:15:47PM +0100, Arjan van de Ven wrote:
> 
> > with DRI you have the case where "something" needs to do security
> > validation of the commands that are sent to the card. (to avoid a
> > non-privileged user to DMA all over your memory)
> 
> We also have the interesting case where your card is behind an
> isolation-capable IOMMU, so if you let userspace program it, you need
> a userspace-accessible DMA-API for IOMMU mappings (or to pre-map
> everything in the IOMMU, which loses on some of the benefits of
> isolation-capable IOMMUs (i.e., only map what you need to use right
> now)).

Userspace IO (UIO) was never intended to replace all kinds of possible
drivers. We wanted to address the situation where a manufacturer of
industrial I/O cards wants to do a large part of his driver in userspace
to simplify his development process. That's all.
Most of these I/O cards have registers or dual ported RAM that can be
mapped to userspace. This is possible with a standard kernel and is done
every day. Problem is that you can't handle interrupts. UIO simply adds
this capability and offers a standardized interface.
The code Greg added to his tree can do this for most hardware found
on industrial IO boards. That's all we wanted to achieve for now. If 
somebody wants to support more sophisticated things, suggestions are
welcome.

Hans

