Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTDKR4g (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDKR4g (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:56:36 -0400
Received: from palrel11.hp.com ([156.153.255.246]:19647 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261360AbTDKR4d (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:56:33 -0400
From: Scott Lee <scottlee@redhot.rose.hp.com>
Message-Id: <200304111808.LAA06725@redhot.rose.hp.com>
Subject: Re: Debugging hard lockups (hardware?)
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2003 11:08:16 -0700 (PDT)
X-Mailer: ELM [$Revision: 1.17.214.2 $]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 06, 2003 at 11:34 AM Alan Cox wrote:
> For the NMI watchdog to fail (if you have it enabled) requires pretty
> major disaster to have occurred since the NMI will be delivered through
> any kind of system hang

Has anyone ever thought about that fact that although the dog might bark (printk), klogd may be deaf in some cases?  It seems to me that there will be cases where this happens and thus we see no data.

I don't know if all x86 hardware has this, but I know that the couple of systems I typically use have a small amount of battery backed ram that is available for use in the RTC.  Anyone ever write a patch to dump data (small stack trace) to this memory so it can be retrieved after a reboot?  It seems to me that some data is better than none...  Of course it would be nice to know what the lowest common denominator is so that one patch will work with all PC hardware but I don't even know if a general approach is really feasible.

Regards,

Scott
