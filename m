Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269335AbUJFSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269335AbUJFSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbUJFSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:01:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:54948 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269335AbUJFSBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:01:55 -0400
Date: Wed, 6 Oct 2004 20:01:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20041006180145.GC10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041006174108.GA26797@kroah.com>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: greg@kroah.com, alan@lxorguk.ukuu.org.uk, rmk+lkml@arm.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 10:41:08 -0700, Greg KH wrote:
> 
> Good point.  So, should we do it in the kernel, in call_usermodehelper,
> so that all users of this function get it correct, or should I do it in
> userspace, in the /sbin/hotplug program?
> 
> Any opinions?

Kernel.

Same reasoning as before, if someone comes along and creates a "much
better" /sbin/hotplug which doesn't handle it, things will break
again.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
