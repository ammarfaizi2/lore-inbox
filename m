Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUENEc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUENEc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 00:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUENEc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 00:32:29 -0400
Received: from taco.zianet.com ([216.234.192.159]:29965 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S263827AbUENEc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 00:32:26 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Thu, 13 May 2004 22:32:01 -0600
User-Agent: KMail/1.6.1
Cc: Andy Isaacson <adi@bitmover.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132232.01484.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Andy Isaacson <adi@bitmover.com> wrote:
>>
>>  We've got a user who's reporting BK problems which we've traced down to
>>  the fact that his s.ChangeSet file has a hole, filled with '\0' bytes,
>>  that's so far always 1352 bytes long, and the end is page-aligned.  (In
>>  fact, the two cases we've seen so far have been 8k-aligned.)  The
>>  correct file data picks up again after the hole.
>
>When the reporter has a PIII machine it's often useful to find out the clock
>frequency - the lower it is, the older it is and the more likely it is that
>some component has rotted.
>
>If this one cannot be reproduced on any other machine I'd say it's a
>hardware failure.

Hi Andrew,

The user is me.  The machine is a 450 Mhz P-III, about five years old now.
Andy mentioned ethernet, but I don't have that here, just 56k dialup.  The
extra information he requested was sent a couple of hours ago, and in the
meantime I ran two full passes of memtest86 3.1 with zero errors.

<slight detour>
I do occasionally have problems with pppd, and the following message always
appears in /var/log/messages:

May 13 18:09:30 spc kernel: serial8250: too much work for irq10
May 13 18:09:30 spc kernel: serial8250: too much work for irq10

The message is always doubled as above.  This has never yet occurred
at the same time as the bk failure, so the two seem unrelated.  I have
to kill -9 the pppd process and reconnect when the above happens.
This problem never happened with a 2.4.x kernel, and was first detected
during the middle of 2.5.x development.
</slight detour>

The only reason the above was at all possibly relevant to the bk failtures,
is that I've only noticed the failures when pulling over the net via ppp.
I've never gotten the failure when pulling from another repository
on the same disk (I've only got one).

If you have any ideas about narrowing down the potentially rotted
component, please let me know.

I cut and pasted the above from a lkml archive, so sorry if this
messes up your mail thread.  I'm not on lkml here at home, so
please cc me on any replies.

Steven
