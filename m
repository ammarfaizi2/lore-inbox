Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVBKKQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVBKKQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 05:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVBKKQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 05:16:36 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:26823 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262236AbVBKKQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 05:16:28 -0500
Subject: Re: USB 2.4.30: fix modem_run
From: Duncan Sands <baldrick@free.fr>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050210161144.708cb96f@localhost.localdomain>
References: <20050210161144.708cb96f@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 11:16:20 +0100
Message-Id: <1108116980.7400.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 16:11 -0800, Pete Zaitcev wrote:
> I entered a patch which adds "exclusive_access" lock into 2.4.29, to fix
> devices which cannot handle simultaneous accesses. This caused a regression
> with European ADSL modems. An ioctl USBDEVFS_REAPURB allows a process to enter
> the kernel and wait for USB I/O to finish. Naturally, this should not take
> exclusive_access, or nothing will ever finish.

How does this compare with the locking in 2.6 kernels?

Thanks,

Duncan.

