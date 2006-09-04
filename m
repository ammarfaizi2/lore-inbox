Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWIDP4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWIDP4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWIDP4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:56:22 -0400
Received: from mx.delair.de ([62.80.31.6]:50661 "EHLO mx.delair.de")
	by vger.kernel.org with ESMTP id S964898AbWIDP4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:56:21 -0400
From: Andreas Hobein <ah2@delair.de>
Organization: delair Air Traffic Systems GmbH
To: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Date: Mon, 4 Sep 2006 17:56:17 +0200
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Markus Gutschke <markus@google.com>
References: <200608312305.47515.ah2@delair.de> <200609041416.03945.ah2@delair.de> <20060904152307.GA98@oleg>
In-Reply-To: <20060904152307.GA98@oleg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609041756.18343.ah2@delair.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 17:23, you wrote:
> Could you test your application with 2.6.18-rc6 and this change
>
> 	-       if (task == current)
> 	+       if (task->tgid == current->tgid)
>
> reverted? I think any report, positive or negative, would be useful.

In fact I applied exactly this change before posting to this mailing list to 
kernel-2.6.17-1.2174_FC5 (Source rpm from fedora core 5) _without_ success. 
Thats why I thought there were also some other changes with similar effects 
in the kernel source at the same time.

> It would be nice if your test covers different conditions, such as
> 'main thread debugs sub-thread' and vice versa. Exec under ptrace is
> also interesting.

In my application a child thread debugs sibling threads and the parent. 
Neither works for newer kernels.

I will try a 2.6.18-rc6 vanilla kernel with the above patch applied at home 
and give you some feedback wether there is a different result as with the 
patched 2.6.17-1.2174_FC5 kernel.

> It's a pity to disappoint you, but you may be the 3rd :) Found this
> unanswered message:
>
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114073955827139

May be there are more advocates of self-debugging than expected ...

	Andreas
