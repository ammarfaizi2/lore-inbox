Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbVBDVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbVBDVwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbVBDVt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:49:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266406AbVBDVho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:37:44 -0500
Date: Fri, 4 Feb 2005 13:37:26 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, zaitcev@redhat.com,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
Subject: Re: 2.6: USB disk unusable level of data corruption
Message-ID: <20050204133726.7ba8944f@localhost.localdomain>
In-Reply-To: <1107519382.1703.7.camel@localhost.localdomain>
References: <1107519382.1703.7.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 23:16:22 +1100, Rusty Russell <rusty@rustcorp.com.au> wrote:

> [...] I have since then had multiple
> ext3 and ext2 errors: 2.6.8, 2.6.9, 2.6.10 and 2.6.11-rc3 all exhibit
> the problem within an hour of stress (untarring a fresh kernel tree, cp
> -al'ing to apply patches repeatedly, my normal workload).

> I realize "ub" exists, but it doesn't seem to want to deal with a disk
> device.

In case your EHCI disconnects devices under load, ub won't help.
You probably heard my claims that ub helps against certain memory
pressure related lockups and against problems in the SCSI stack,
which my even be true. Jury is still out on those and your case
seems different anyway. Please work with David Brownell on the EHCI
issues. I applied a few patches of his to the 2.4 which made a difference
in similar circumstances.

Good luck,
-- Pete
