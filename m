Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271939AbTHSRbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHSRIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:08:14 -0400
Received: from rth.ninka.net ([216.101.162.244]:34950 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S271939AbTHSQzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:55:55 -0400
Date: Tue, 19 Aug 2003 09:55:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jes@wildopensource.com, zaitcev@redhat.com, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030819095547.2bf549e3.davem@redhat.com>
In-Reply-To: <1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 14:07:18 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> It is messy, but the consistent mask only helps a small subset of cases.
> Having an __pci_alloc_foo that took the mask as an argument is (a)
> trivial (b) adds almost no code  (c) solves the general case problem.

(d) Makes implementations have to verify the mask is usable
on every mapping attempt.
