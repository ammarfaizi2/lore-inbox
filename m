Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUAQAvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 19:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbUAQAvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 19:51:00 -0500
Received: from main.gmane.org ([80.91.224.249]:4003 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265863AbUAQAu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 19:50:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] add sysfs class support for ALSA sound devices [08/10]
Date: Sat, 17 Jan 2004 01:50:55 +0100
Message-ID: <yw1xektz75zk.fsf@kth.se>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com>
 <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com>
 <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com>
 <20040115204241.GG22199@kroah.com> <20040115204259.GH22199@kroah.com>
 <20040115204311.GI22199@kroah.com> <yw1xu12v7d5t.fsf@kth.se>
 <20040117001009.GB3698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:TskTvJmWmZcc40/erKzfKACpcwQ=
Cc: linux-hotplug-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Fri, Jan 16, 2004 at 11:15:58PM +0100, Måns Rullgård wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> > This patch adds support for all ALSA sound devices.  The previous OSS
>> > sound patch is required for this one to work properly.
>> 
>> This doesn't apply cleanly to the latest ALSA (1.0.1).  It's no
>> problem to do it manually, though.
>> 
>> > diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
>> > --- a/sound/pci/intel8x0.c	Thu Jan 15 11:05:58 2004
>> > +++ b/sound/pci/intel8x0.c	Thu Jan 15 11:05:58 2004
>> > @@ -2591,6 +2591,7 @@
>> >  			break;
>> >  		}
>> >  	}
>> > +	card->dev = &pci->dev;
>> 
>> Does this need to be done for all drivers?
>
> Yes.  I just did it for one driver to test it out, and show how to do it
> properly for others.  I figured after this patch went into the kernel
> tree, we could fix the other drivers up.

Well, it seems to work with my intel8x0 and ALSA 1.0.1.

-- 
Måns Rullgård
mru@kth.se

