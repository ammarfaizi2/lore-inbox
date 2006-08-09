Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWHIJFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWHIJFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWHIJFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:05:08 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:34236 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030589AbWHIJFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:05:06 -0400
Message-ID: <44D9A483.1020203@aitel.hist.no>
Date: Wed, 09 Aug 2006 11:01:55 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Neil Brown <neilb@suse.de>, Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
References: <or8xlztvn8.fsf@redhat.com> <17624.29070.246605.213021@cse.unsw.edu.au> <44D8732C.2060207@tls.msk.ru>
In-Reply-To: <44D8732C.2060207@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Why we're updating it BACKWARD in the first place?
>   
Don't know this one...
> Also, why, when we adding something to the array, the event counter is
> checked -- should it resync regardless?
If you remove a drive and then add it back with
no changes in the meantime, then you don't want
a resync to happen.  Some people reboot their machine
every day (too much noise, heat or electricity at night),
a daily resync is excessive.

An which drive would you consider
the "master copy" anyway, if the event counts match?

Helge Hafting

