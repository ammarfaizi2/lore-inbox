Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUFEVr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUFEVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFEVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:47:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:22237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262050AbUFEVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:47:24 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605140544.0de4034d.davem@redhat.com>
	<jer7st7lam.fsf@sykes.suse.de>
	<20040605143649.3fd6c22b.davem@redhat.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm dressing up in an ill-fitting IVY-LEAGUE SUIT!!  Too late...
Date: Sat, 05 Jun 2004 23:47:22 +0200
In-Reply-To: <20040605143649.3fd6c22b.davem@redhat.com> (David S. Miller's
 message of "Sat, 5 Jun 2004 14:36:49 -0700")
Message-ID: <jen03h7k45.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Sat, 05 Jun 2004 23:21:53 +0200
> Andreas Schwab <schwab@suse.de> wrote:
>
>> "David S. Miller" <davem@redhat.com> writes:
>> 
>> > This means also that Olaf's patch is broken, when CONFIG_COMPAT is not
>> > set, MSG_CMSG_COMPAT is zero, thus ~MSG_CMSG_COMPAT is the unexpected
>> > value all 1's thus breaking the tests for unexpected flags completely.
>> 
>> ??? Where do you get ~MSG_CMSG_COMPAT from?
>
> Olaf's patch, it said:
>
> -	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC))
> +	if (flags & ~(MSG_PEEK|MSG_DONTWAIT|MSG_TRUNC|MSG_CMSG_COMPAT))

Yes, and where is the problem?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
