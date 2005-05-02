Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVEBWuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEBWuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVEBWug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:50:36 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:8602 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S261201AbVEBWu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:50:29 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
References: <42748B75.D6CBF829@tv-sign.ru>
	<20050501023149.6908c573.akpm@osdl.org>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Oleg Nesterov
	<oleg@tv-sign.ru>, linux-kernel@vger.kernel.org, maneesh@in.ibm.com,
	benh@kernel.crashing.org
Date: Tue, 03 May 2005 00:50:24 +0200
In-Reply-To: <20050501023149.6908c573.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 1 May 2005 02:31:49 -0700")
Message-ID: <87vf61kztb.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Oleg Nesterov <oleg@tv-sign.ru> wrote:
>>
>> When __mod_timer() changes timer's base it waits for the completion
>> of timer->function. It is just stupid: the caller of __mod_timer()
>> can held locks which would prevent completion of the timer's
>> handler.
>>
>> Solution: do not change the base of the currently running timer.
>
> OK, fingers crossed.  Juergen, it would be great if you could test
> Oleg's patch sometime.

I had one more lockup yesterday but that probably was caused by
something else because Azureus is running fine for 24 hours now.

Thanks Oleg!


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
