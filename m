Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWBZWJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBZWJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWBZWJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:09:43 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:23973 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751144AbWBZWJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:09:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+fvsy+mI7tcgqAfDuUUoWZzGmbrvnNyFs57RTBw3kR5V3/ZRVYe+BPmq1SLqXMo8M6rZYxs77gMo/zhMGzJN49S8Lr51H6gfiHJgKxckwotL5DOq2PaAuzHPzwgbBFKXvP/HJKeLAodhTl/KhL2+AhFhrBieivq/tqiUDo2suY=
Message-ID: <21d7e9970602261409r578e9a4cqd50c59eb66db303f@mail.gmail.com>
Date: Mon, 27 Feb 2006 09:09:40 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: old radeon latency problem still unfixed?
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>
In-Reply-To: <1140989703.24141.164.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140917787.24141.78.camel@mindpipe>
	 <20060226014437.327b1cc3.akpm@osdl.org>
	 <1140947860.2934.12.camel@laptopd505.fenrus.org>
	 <1140982763.24141.123.camel@mindpipe>
	 <21d7e9970602261331n128d50f3g55af85d7c8c27f93@mail.gmail.com>
	 <1140989703.24141.164.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-02-27 at 08:31 +1100, Dave Airlie wrote:
> > >
> > > Thanks I will check on this.
> > >
> >
> > I don't suppose they are running with X renice -10?
> >
> > or some such.. that was done by a few vendors previously.. if X is
> > using hw accel, then it will be in the DRM driver a bit...
>
> Radeon uses DRI for regular 2D XAA acceleration?  That's good to know.
>
> This is not very common right?

Common in what sense? all radeons that have DRM enabled use the CP to
do 2D XAA accel, the drm is the interface to the CP, granted it
doesn't do a huge amount of work, X sets up all the accel in an
indirect buffer, and just tells the DRM where the buffer starts.. so
it isn't doing a lot in the kernel.

Dave.
>
> Lee
>
>
