Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWAZGOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWAZGOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 01:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWAZGOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 01:14:49 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:32021 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932083AbWAZGOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 01:14:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJqv3tQVsPQQ0N8WDOr1DKCJem24f3t7CKIkM6QKP1KrAQjMuDIEkc8estAkT1pUf88fmOmPdBZYRGD0V4jKYdrmzRQ8JZD8Iha3KdOCOyUlgpKptxSQHTU8m4siyKMVxwsWzRbnuMLMrZz5z9Z5h6s1KFraCwqbMta9vy7cOVY=
Message-ID: <93564eb70601252214reae7db6j@mail.gmail.com>
Date: Thu, 26 Jan 2006 15:14:46 +0900
From: Samuel Masham <samuel.masham@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Cc: davids@webmaster.com, lkml@rtr.ca,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
In-Reply-To: <1138251234.3087.107.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D8386B.6000204@rtr.ca>
	 <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
	 <93564eb70601251949r1fb4c209t@mail.gmail.com>
	 <93564eb70601252002x5949b65fs@mail.gmail.com>
	 <1138251234.3087.107.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2006-01-26 at 13:02 +0900, Samuel Masham wrote:
> > On 26/01/06, Samuel Masham <samuel.masham@gmail.com> wrote:
> > > comment:
> > > As a rt person I don't like the idea of scheduler bounce so the way
> > > round seems to be have the mutex lock acquiring work on a FIFO like
> > > basis.
> >
> > which is obviously wrong...
> >
> > Howeve my basic point stands but needs to be clarified a bit:
> >
> > I think I can print non-compliant if the mutex acquisition doesn't
> > respect the higher priority of the waiter over the current process
> > even if the mutex is "available".
> >
> > OK?
>
> I don't think using an optional feature (PI) counts...
>
> Lee

So when acquiring a mutex with pi enabled must involve scheduler...

... and you can skip that bit with it disabled as one can argue that
the user can't tell if the time slice hit between the call to acquire
the mutex and the actual mutex wait itself?

sounds a bit of a fudge to me....

I assume that mutexes will must never support a the wchan (proc)
interface or the like?

On the other hand the basic point about high contention around mutexes
and relying on this being a bad idea is fine by me.

Samuel
