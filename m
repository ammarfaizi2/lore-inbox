Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSLQTOM>; Tue, 17 Dec 2002 14:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSLQTOM>; Tue, 17 Dec 2002 14:14:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265643AbSLQTOF>; Tue, 17 Dec 2002 14:14:05 -0500
Message-ID: <3DFF7951.6020309@transmeta.com>
Date: Tue, 17 Dec 2002 11:21:53 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 17 Dec 2002, Ulrich Drepper wrote:
> 
>>But this is exactly what I expect to happen.  If you want to implement
>>gettimeofday() at user-level you need to modify the page.
> 
> Note that I really don't think we ever want to do the user-level
> gettimeofday(). The complexity just argues against it, it's better to try
> to make system calls be cheap enough that you really don't care.
> 

Let's see... it works fine on UP and on *most* SMP, and on the ones
where it doesn't work you just fill in a system call into the vsyscall
slot.  It just means that gettimeofday() needs a different vsyscall slot.

	-hpa

