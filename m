Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUHJQJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUHJQJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHJQGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:06:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:8653 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267503AbUHJQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:05:10 -0400
Subject: Re: [PATCH] [LSM] Rework LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Xine.LNX.4.44.0408101006580.7711-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0408101006580.7711-100000@dhcp83-76.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092150120.16939.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 16:02:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-10 at 15:16, James Morris wrote:
> On Tue, 10 Aug 2004, Kurt Garloff wrote:
> 
> > * Even with selinux=0 and capability loaded, the kernel takes a 
> >   few percents in networking benchmarks (measured by HP on ia64); 
> >   this is caused by the slowliness of indirect jumps on ia64.
> 
> Is this just an ia64 issue?  If so, then perhaps we should look at only
> penalising ia64?  Otherwise, loading an LSM module is going to cause
> expensive false unlikely() on _every_ LSM hook.

I see this on x86-32 to an extent. Its quite visible with gigabit as
you'd expect. ia64 ought to be less affected providing the compiler is
doing the right things with the unconditional jumps.


Alan

