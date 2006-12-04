Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935553AbWLDKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553AbWLDKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935587AbWLDKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:15:09 -0500
Received: from main.gmane.org ([80.91.229.2]:29083 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S935553AbWLDKPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:15:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tobias Oed <tobiasoed@hotmail.com>
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
Date: Mon, 04 Dec 2006 11:10:01 +0100
Message-ID: <el0s6r$agu$1@sea.gmane.org>
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us> <45732C8E.4060801@wpkg.org>
Reply-To: tobiasoed@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mut38-3-82-226-72-184.fbx.proxad.net
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski wrote:

> Ross Vandegrift wrote:
>> On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
>>> You mean the "Used by" column? No, it's not used by any other module
>>> according to lsmod output.
>>>
>>> Any other methods of checking what uses /dev/sda*?
>> 
>> There's a good chance that if it was loaded at system boot, hald or
>> udev may be doing something with it.
> 
> This machine doesn't have hal; when I kill udevd still doesn't help.
> 
> Yes, something's using that drive, be it a program, a module (unlikely),
> or something that is compiled directly in the kernel (for example,
> md/raid1).
> But what is it?

Since you mention md, dm comes to mind. I have seen a couple of drives that
were previously attached to fake raid controllers becoming unavailable when
moved to a normal controller. I haven't found the one size workaround for
the problem yet. Can you check
/sys/block/sda/holders ?
Also /sys/bus/ide/whoevertheholderis/[bind|unbind] are 'curious' but I'm not
sure how one is supposed to use them.
Tobias



