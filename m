Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVL0F1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVL0F1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVL0F1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:27:53 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:2788 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932236AbVL0F1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:27:53 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: gcoady@gmail.com, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: [stable] Re: Linux 2.6.14.5
Date: Tue, 27 Dec 2005 16:28:02 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <qri1r190991kj6a3pr5itv7n7a24a11nh4@4ax.com>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com> <20051227034622.GA23521@kroah.com>
In-Reply-To: <20051227034622.GA23521@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 19:46:23 -0800, Greg KH <greg@kroah.com> wrote:

>On Tue, Dec 27, 2005 at 02:06:03PM +1100, Grant Coady wrote:
>> On Mon, 26 Dec 2005 16:53:27 -0800, Greg KH <gregkh@suse.de> wrote:
>> 
>> >We (the -stable team) are announcing the release of the 2.6.14.5 kernel.
>> >
>> >The diffstat and short summary of the fixes are below.
>> >
>> >I'll also be replying to this message with a copy of the patch between
>> >2.6.14.4 and 2.6.14.5, as it is small enough to do so.
>> 
>> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
>> on this box) or 2.4.32 :(  Same ruleset as used for months.
>
>Is it broken compared to 2.6.14.4 and/or 2.6.14?  Care to figure out
>which release broke it?

2.6.14.4 -> 2.6.14.5 broke it, 2.6.14 also runs okay, some more info 
on http://bugsplatter.mine.nu/test/boxen/deltree/ -- dmesg, `grep = 
.config`.

This box is the bugsplatter web server, currently running 2.6.14.4.

iptables/netfilter is rejecting constructs containing "state NEW", see:
http://bugsplatter.mine.nu/test/boxen/deltree/iptables-vnL-2.6.14.4-dt
vs
http://bugsplatter.mine.nu/test/boxen/deltree/iptables-vnL-2.6.14.5-dt
some numbers masked with 'zxcv' to protect the guilty :)

Grant.
