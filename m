Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163465AbWLGV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163465AbWLGV5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163470AbWLGV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:57:49 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:37583 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163465AbWLGV5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:57:48 -0500
Message-ID: <45788E55.5070009@nortel.com>
Date: Thu, 07 Dec 2006 15:57:41 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: additional oom-killer tuneable worth submitting?
References: <45785DDD.3000503@nortel.com> <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com> <457886B4.2030507@nortel.com> <9a8748490612071337p612f7a2t5fd31968a9ff5da9@mail.gmail.com>
In-Reply-To: <9a8748490612071337p612f7a2t5fd31968a9ff5da9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2006 21:57:52.0953 (UTC) FILETIME=[BE835A90:01C71A4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
>> Jesper Juhl wrote:

>> > What happens in the case where the OOM killer really, really needs to
>> > kill one or more processes since there is not a single drop of memory
>> > available, but all processes are below their configured thresholds?

> I realize that if this case happens the system is misconfigured as far
> as oomthresh goes, but if this is a knob that we put in the mainline
> kernel then I believe there should be some sort of emergency handling
> code that takes this situation into account.  Perhaps throw some very
> nasty looking log messages and then fall back to the classic OOM
> killer behaviour..?

Yeah, I can see that the reboot might be a bit drastic for mainline.  I 
think the fallback to classic behaviour might work okay.

Anyway, the chances of hitting that case are likely pretty slim.  The 
way we've been using this is to only set the threshold for fairly 
important long-lived daemons.  Much of the "standard" stuff (shell, cat, 
cp, mv, etc.) is left unprotected.

Chris
