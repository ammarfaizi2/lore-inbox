Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUCaRip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCaRip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:38:45 -0500
Received: from [63.107.13.101] ([63.107.13.101]:24230 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S262193AbUCaRio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:38:44 -0500
Message-ID: <406B0219.3000309@metavize.com>
Date: Wed, 31 Mar 2004 09:38:33 -0800
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
References: <40311703.8070309@metavize.com> <20040217051911.6AC112C066@lists.samba.org> <20040331165656.GG19280@mail.shareable.org>
In-Reply-To: <20040331165656.GG19280@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I still get them in 2.6.4

To my knowledge, they only happen when one thread is blocked in a system 
call
and another thread makes a system("foo bar") call.
The blocked thread will return with EINTR.
I see this usually in sem_wait, but also in epoll_wait sometimes.

Is it possible system() is causing the wrong process to get woken up?

Let me know if you need any further information, I can reproduce it 
consistently.

Jamie Lokier wrote:

>Was the badness in futex_wait problem ever resolved?
>
>-- Jamie
>  
>

