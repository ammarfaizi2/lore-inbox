Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbTL3LOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbTL3LOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:14:17 -0500
Received: from 30.Red-80-36-221.pooles.rima-tde.net ([80.36.221.30]:18564 "EHLO
	sacarino.pirispons.net") by vger.kernel.org with ESMTP
	id S265750AbTL3LOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:14:11 -0500
Date: Tue, 30 Dec 2003 12:14:08 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: A couple of questions about laptop-mode for 2.6, version 4
Message-ID: <20031230111408.GA22920@sacarino.pirispons.net>
Mail-Followup-To: Bart Samwel <bart@samwel.tk>,
	linux-kernel@vger.kernel.org
References: <20031230092831.GA20414@sacarino.pirispons.net> <3FF15849.60005@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF15849.60005@samwel.tk>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2003 at 11:49, Bart Samwel wrote:

> As I'm not subscribed to the mailing list, I have seen the message but I 
> was unable to reply. AFAICS it's customary to use "reply all" when 
> replying to LKML messages, because of the high volume of mailing list 
> traffic.

Ah!, no problem at all. I'm used to hit "List Reply" on Mutt (and Mutt
relies on Mail-Followup-To: header, http://cr.yp.to/proto/replyto.html).
I will take note on your advice.

Hope you don't mind I'm sending a copy to the lkml so that it's archived
in case it could be useful to someone (and hope the list does'nt mind
too).

> 3. Remounting seems the only option to me, because laptop_mode contains 
> no automatic adjustment. The 2.4 patch used to contain this, but it was 
> not integrated into 2.4.23, for good reasons -- it took away the user's 
> choice on which filesystems got a higher commit interval.

Oh!, I didn't notice that part wasn't included in 2.4.23. Thanks for the
info.

> If you use the /proc/mounts option, you can start a "daemon" script to 
> monitor the /proc/mounts, and to immediately remount any new ext3 
> filesystems with a higher commit interval depending on the status of 
> /proc/sys/vm/laptop_mode. This script could then also remount all of 
> them back to normal whenever laptop_mode switched back to 0.

OK, I see it.

I think I will do things just "by hand". I don't feel like having a
daemon messing with filesystems (it seems to mee quite far from the KISS
philosophy).

Btw, have you had reliability reports? Do you know if it's going to be
included in 2.6 "official" tree shortly?

> Hope this answers your questions.

Sure it does, thanks a lot!

-- 
Kiko
