Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWCAO56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWCAO56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCAO55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:57:57 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:31426 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932297AbWCAO55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:57:57 -0500
Date: Wed, 01 Mar 2006 23:57:50 +0900 (JST)
Message-Id: <20060301.235750.25910018.anemo@mba.ocn.ne.jp>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44059915.3010800@yahoo.com.au>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
	<20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
	<44059915.3010800@yahoo.com.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 01 Mar 2006 23:52:37 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

>> void do_timer(struct pt_regs *regs)
>> {
>> -	jiffies_64++;
>> -	update_times();
>> +	update_times(++jiffies_64);
>>  	softlockup_tick(regs);
>> }

nick> jiffies_64 is not volatile so you should not have to obfuscate
nick> the code like this.

Well, do you mean it should be like this ?

	jiffies_64++;
	update_times(jiffies_64);

Thanks for your comments.
---
Atsushi Nemoto
