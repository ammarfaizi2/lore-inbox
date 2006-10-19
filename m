Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161433AbWJSOna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbWJSOna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbWJSOna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:43:30 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:6036 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161433AbWJSOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:43:30 -0400
Message-ID: <45378F08.5090204@qumranet.com>
Date: Thu, 19 Oct 2006 16:43:20 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com>	<453781F9.3050703@qumranet.com> <17719.35854.477605.398170@smtp.charter.net>
In-Reply-To: <17719.35854.477605.398170@smtp.charter.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 14:43:27.0738 (UTC) FILETIME=[F0316DA0:01C6F38C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> Avi> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s
> Avi> allow adding memory to a virtual machine, adding a virtual cpu to
> Avi> a virtual machine (at most one at this time), transferring
> Avi> control to the virtual cpu, and querying about guest pages
> Avi> changed by the virtual machine.
>
> Yuck.  ioclts are deprecated, you should be using /sysfs instead for
> stuff like this, or configfs.  
>   

I need to pass small amounts of data back and forth very efficiently.  
sysfs and configfs are more for one-time admin stuff, not for continuous 
device control.


-- 
error compiling committee.c: too many arguments to function

