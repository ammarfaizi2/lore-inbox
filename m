Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUJFVha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUJFVha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUJFVdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:33:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30124 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269467AbUJFVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:32:25 -0400
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
	availlable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006205417.GA25437@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
	 <20041005212712.I6910@flint.arm.linux.org.uk>
	 <20041005210659.GA5276@kroah.com>
	 <20041005221333.L6910@flint.arm.linux.org.uk>
	 <1097074822.29251.51.camel@localhost.localdomain>
	 <20041006174108.GA26797@kroah.com>
	 <1097090333.29706.4.camel@localhost.localdomain>
	 <20041006205417.GA25437@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097094582.29866.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 21:29:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 21:54, Greg KH wrote:
> Ok, then anyone with some serious bash-foo care to send me a patch for
> the existing /sbin/hotplug file that causes it to handle this properly?

Something like

#!/bin/sh
(
Everything you had before
) <>/dev/console 2>&1


