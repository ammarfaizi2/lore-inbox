Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269172AbSIRWHY>; Wed, 18 Sep 2002 18:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269205AbSIRWHY>; Wed, 18 Sep 2002 18:07:24 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5128 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269172AbSIRWHY>;
	Wed, 18 Sep 2002 18:07:24 -0400
Date: Wed, 18 Sep 2002 15:12:27 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918221227.GK10970@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A6C@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A6C@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 05:51:30PM -0400, Bloch, Jack wrote:
> Thanks for the help, but a generic question. If my HW has a hotswap
> controller (theoretically), I do not need any thrird party SW to handle the
> hot swap insert/remove. Linux 2.4.18-3 Kernel should support this correct?

The kernel will support this, yes, but you need to run some kind of
userspace software to turn on or off slots.  Or if you have hardware
that recognizes that the power needs to be removed or applied (through a
latch on the slot), it could all be handled with no user interaction at
all.

> I should just run /sbin/hotplug pci on start up.

No, the kernel runs /sbin/hotplug when it sees a new pci device, or when
one is removed.  A user never runs it on their own.

Hope this helps,

greg k-h
