Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbULVO7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbULVO7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbULVO7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:59:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38539 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261846AbULVO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:59:19 -0500
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87hdme31xl.fsf@coraid.com>
References: <87k6rhc4uk.fsf@coraid.com>
	 <1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
	 <87hdme31xl.fsf@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103723728.8165.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 22 Dec 2004 13:55:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-22 at 13:19, Ed L Cashin wrote:
> Scott Feldman <sfeldma@pobox.com> writes:
> > Is there a better way to handle errors than flooding the log?
> 
> These errors haven't happened much, but if they did, I'd want
> everybody to know.  Would you suggest a per-device counter to limit
> how many times this message gets printed?  

And a sensible KERN_ level like KERN_WARNING. KERN_CRIT is used when
something catastrophic just occurred and the box is as good as defunct.
Take a look at "net_ratelimit()"

Alan

