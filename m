Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269345AbUJFSRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269345AbUJFSRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269351AbUJFSRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:17:11 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:5133 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269345AbUJFSRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:17:02 -0400
Date: Wed, 6 Oct 2004 20:16:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006181654.GB4523@pclin040.win.tue.nl>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006174108.GA26797@kroah.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 10:41:08AM -0700, Greg KH wrote:

> Good point.  So, should we do it in the kernel, in call_usermodehelper,
> so that all users of this function get it correct, or should I do it in
> userspace, in the /sbin/hotplug program?

The doctrine of defensive programming will teach you to write
/sbin/hotplug so that it can cope with such things.

(But I do not object at all to also doing it in the kernel.
Some would call it "papering over user space bugs", but one might
as well call it "making the system more robust".)

Andries
