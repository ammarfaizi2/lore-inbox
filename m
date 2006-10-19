Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946468AbWJSUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946468AbWJSUet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946470AbWJSUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:34:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28315 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946468AbWJSUer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:34:47 -0400
Subject: Re: [PATCH 1/7] KVM: userspace interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: John Stoffel <john@stoffel.org>, Avi Kivity <avi@qumranet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4537C8B3.5050501@us.ibm.com>
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>
	 <17719.35854.477605.398170@smtp.charter.net>
	 <1161269405.17335.80.camel@localhost.localdomain>
	 <4537C8B3.5050501@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 21:36:40 +0100
Message-Id: <1161290200.17335.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 13:49 -0500, ysgrifennodd Anthony Liguori:
> ioctls are probably wrong here though.  Ideally, you would want to be 
> able to support an SMP guest.  This means you need to have two virtual 
> processors executing in kernel space.  If you use ioctls, it forces you 

Not really and in fact with qemu you'd want to halt a trap on the second
virtual CPU until emulation was over if only to get I/O and other
instruction ordering right. Thats not an argument that only that view
should be supported of course.

> If you used a read/write interface, you could poll for any number of 
> processors and handle IO emulation in a single userspace thread (which 
> seems closer to how hardware really works anyway).

Agreed.

Alan

