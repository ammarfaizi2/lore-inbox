Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWGLWDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWGLWDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWGLWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:03:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51861 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932463AbWGLWDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:03:44 -0400
Message-ID: <44B57191.5000802@zytor.com>
Date: Wed, 12 Jul 2006 15:02:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>	 <1152739766.3217.83.camel@laptopd505.fenrus.org>	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com> <1152741665.3217.85.camel@laptopd505.fenrus.org>
In-Reply-To: <1152741665.3217.85.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> It is a short busy wait before falling asleep.  I assume you mean
>> busy wait is a loss even on SMP?
> 
> eh yeah I forgot to think for a second. But yes even for SMP busy wait
> is pretty bad power wise nowadays.. at least if you wait more than a few
> hundred cycles. (and if you wait less... then it's almost unlikely that
> it'll be useful as well)
> 

It depends greatly; if a lock is likely to get released by the user 
after a few memory accesses, spinning is likely to be a win.

	-hpa

