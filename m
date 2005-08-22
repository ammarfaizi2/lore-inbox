Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVHVWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVHVWFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVHVWFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:05:10 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:17630 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750863AbVHVWFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:05:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LcldWrY3b0AHDjEUsUvindnxDkBAoMFn3YM1+sd/CUU8KYALAvxLOws+kTqCT30ktufC9mFZCK6BmdGap+4VFAyBYHApBptJ/8C5aU7JNQRzT4VD93I1Hq5GzytEF2RutHWNo3hsX0B9QuGXObudtWLjSoSz4NTELBLLhXFWw4U=
Message-ID: <9a8748490508221505649d8889@mail.gmail.com>
Date: Tue, 23 Aug 2005 00:05:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Brian D. McGrew" <brian@visionpro.com>
Subject: Re: Binding a thread (or specific process) to a designated CPU
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Brian D. McGrew <brian@visionpro.com> wrote:
> Good morning,
> 
> Using FC3 or FC4 with the 2.6.9 or later kernel, we're looking for a way
> to bind a thread (or an entire process) to a designated CPU.  We're

       #include <sched.h>

       int sched_setaffinity(pid_t pid, unsigned int len, unsigned long *mask);
       int sched_getaffinity(pid_t pid, unsigned int len, unsigned long *mask);


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
