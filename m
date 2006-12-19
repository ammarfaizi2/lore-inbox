Return-Path: <linux-kernel-owner+w=401wt.eu-S1752633AbWLSGWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWLSGWR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbWLSGWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:22:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:17783 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbWLSGWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:22:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EvSS+6Rtt1Qr9XK4iCP938HcBSGSlaEokfVuMxkvB6gQrW1Pk6yyH0IEWT1hY8UTuUcCaI6/fcTMovKhakvzlwjnyflimH7ksRjiFsue/Uy7e+O+M5DLP2cFAN+RFO26LrlJvY7uJPUbK3K752+fskU+CCmUqd4aiOBRedfYF54=
Message-ID: <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
Date: Tue, 19 Dec 2006 12:07:14 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Erik Mouw" <mouw@nl.linux.org>, nickpiggin@yahoo.com.au
Subject: Re: Linux disk performance.
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061218130702.GA14984@gateway.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Erik Mouw <mouw@nl.linux.org> wrote:
<...snip...>
> >
> > But isn't O_DIRECT supposed to bypass buffering in Kernel?
>
> It is.
>
> > Doesn't it directly write to disk?
>
> Yes, but it still uses an IO scheduler.
>

Ok. but i also tried with noop to turnoff disk scheduling effects.
There was still timing differences. Usually i get 3100 microseconds
but upto 20000 microseconds at certain intervals. I am just using
gettimeofday between two writes to read the timing.



> In your first message you mentioned you were using an ancient 2.6.10
> kernel. That kernel uses the anticipatory IO scheduler. Update to the
> latest stable kernel (2.6.19.1 at time of writing) and it will default
> to the CFQ scheduler which has a smoother writeout, plus you can give
> your process a different IO scheduling class and level (see
> Documentation/block/ioprio.txt).

Thanks... i will try with CFQ.



Nick Piggin:
> but
> they look like they might be a (HZ quantised) delay coming from
> block layer plugging.

Sorry i didn´t understand what you mean.

To minimise scheduling effects i tried giving it maximum priority.


-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
