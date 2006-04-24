Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDXN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDXN4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDXN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:56:00 -0400
Received: from [212.70.57.106] ([212.70.57.106]:51724 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750809AbWDXN4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:56:00 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Mon, 24 Apr 2006 16:53:49 +0300
User-Agent: KMail/1.5
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200511142327.18510.a1426z@gawab.com> <200604241412.13267.a1426z@gawab.com> <84144f020604240422v3f0cd85fm6f45d263d60803cf@mail.gmail.com>
In-Reply-To: <84144f020604240422v3f0cd85fm6f45d263d60803cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241653.49647.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 4/24/06, Al Boldi <a1426z@gawab.com> wrote:
> > Like so?
> >         if (nr_threads >= max_threads)
> >                 if (p->pid != su_pid)
> >                         goto bad_fork_cleanup_count;
>
> It's better to combine the two if statements into one with &&.

I thought of combining them too, but was afraid of some compile optimization 
issues.  Remember, this code-path is executed for each and every fork in the 
system, thus it's highly performance sensitive.

Thanks!

--
Al

