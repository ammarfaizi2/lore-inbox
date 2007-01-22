Return-Path: <linux-kernel-owner+w=401wt.eu-S1750994AbXAVJ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXAVJ0P (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 04:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXAVJ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 04:26:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:37912 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbXAVJ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 04:26:14 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gx/LYgSRgjrLqqTOqYP7vskv5jS9jGQCMPAbbE3MyZPMIV/zV3sxAMwh+c2p4PxXv07AuFWEmwUJYXFEa/RKhGxBrogmz/jVWlfa6iQbIeb19gKOK2+heDhuOznzJOliTU/cxnvz2AkMLY2RJp2uwfy/CqIJFW/9syq4A3npghA=
Message-ID: <e92e3a770701220126h767c7789gd5bed3ddef07f809@mail.gmail.com>
Date: Mon, 22 Jan 2007 14:56:13 +0530
From: "kalash nainwal" <nirvana.code@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: wake_up() takes long time to return
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1169304446.3055.764.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e92e3a770701200224n42c948d5oe75aa5eb907e9786@mail.gmail.com>
	 <1169304446.3055.764.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2007-01-20 at 15:54 +0530, kalash nainwal wrote:
> > Hi there,
> >
> > We've a kernel (n/w) module, which sits over ethernet. Whenever a pkt
> > is received (in softirq), after doing some minimal processing,
> > wake_up() is called to wake up another kernel thread which does rest
> > (bulk) of the processing.
> >
> > We notice that this wake_up() call is sometimes taking as long as 48
> > milli-seconds to return. This happens around 10 times out of 10M. We
> > earlier thought its possibly because of the contention on rq->lock,
> > but we see the same phenomenon even on a uniprocessor box. So obviosly
> > thats not the case.
> >
> > We can't figure out any other reason for wake_up() to take this much
> > time? As this call comes directly in our (receive) hotpath, we're very
> > concerned. Any help would be greatly appreciated.
>
>
> Hi,
>
> unfortunately you didn't provide your driver code or a link to it, so
> people who want to help you would have to guess in the dark... could you
> reply to this email with the pointer to the code?
>
> Greetings,
>    Arjan van de Ven
> --
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
>
>

Hi Arjan,

I won't pretend I'm working on an open-source driver. I personally
would be more than happy to share the driver code, but doing so would
probably cost me my job :)

and so...I won't expect anyone to help me with my code either.

Just wanted to know if wake_up is known to take this long to return?
(some known linux quirk may be?) If so then under what conditions? or
it _definitely_ would be my code only that's screwing up?

I'm using do_gettimeofday() before and after wake_up() to measure this time.

Thanks and regards,
-Kalash
