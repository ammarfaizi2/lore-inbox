Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCLWPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCLWPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWCLWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:15:43 -0500
Received: from rtr.ca ([64.26.128.89]:49330 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750772AbWCLWPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:15:43 -0500
Message-ID: <44149D6A.7080005@rtr.ca>
Date: Sun, 12 Mar 2006 17:15:06 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Marr <marr@flex.com>
Cc: Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
 Calls From 2.4 to 2.6 -- VMM Change?)
References: <200602241522.48725.marr@flex.com> <200603071453.46768.marr@flex.com> <440DF802.8@tlinx.org> <200603121653.30288.marr@flex.com>
In-Reply-To: <200603121653.30288.marr@flex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr wrote:
>
> I tried turning 'readahead' off entirely ('hdparm -A0 /dev/hda') and, although 

No, that should be "hdparm -a0 /dev/hda" (lowercase "-a").
And the same "-a" for all of your other test variants.

If you did it all with "-A", then the results are invalid,
and need to be redone.

The hdparm manpage explains this, but in a nutshell, "-A" is the
low-level drive firmware "look-ahead" mechanism, whereas "-a" is
the Linux kernel "read-ahead" scheme.

In general, most uppercase hdparm flags are drive *firmware* settings.

Cheers
