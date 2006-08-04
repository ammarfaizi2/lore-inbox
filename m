Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWHDAPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWHDAPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWHDAPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:15:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:61429 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932360AbWHDAPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DzSDukeD1XyGfLUhstU/guymkRc9zLZPNBXukJzpaKookXYBJp6/1m6TKXhegV4+PFq6kGTJVDOT4FJ+wWC6rMvDku8t2IrdjyIHedtA7fdR1VEKTLmKoQ0qTrs5GFRD0k6KXh7ZPsOzNgXSd0LgkG2XA/rrf8CrDhzf3EkT6fc=
Message-ID: <5c49b0ed0608031715l7e8f9c7dyd647a11c44c73400@mail.gmail.com>
Date: Thu, 3 Aug 2006 17:15:47 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [PATCH -mm] [1/2] Remove Deadline I/O scheduler
Cc: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060803234648.GK25692@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c49b0ed0608031557n405196ack3fa2024aae8a9475@mail.gmail.com>
	 <20060803234648.GK25692@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Aug 03, 2006 at 03:57:32PM -0700, Nate Diller wrote:
>
> > This patch removes the Deadline I/O scheduler.  Performance-wise, it
> > should be superceeded by the Elevator I/O scheduler in the following
> > patch.  I would be very ineterested in hearing about any workloads or
> > benchmarks where Deadline is a substantial improvement over Elevator,
> > in throughput, fairness, latency, anything.
> >...
>
> You are starting with the last step.

You're right, I should have made myself clear.  My goal is not to get
deadline removed, but a discussion with Andrew some months ago showed
he was averse to creating more options than we already have.  So since
I expect elevator can surpass deadline, I wanted to show that I think
deadline is the one that it should replace.  Certainly, CFQ and as can
both beat elevator for a good number of workloads.
>
> First, get your Elevator I/O scheduler reviewed [1] and show some data
> that backs your "it should be superceeded by the Elevator I/O scheduler"
> claim.
>
> Then get your Elevator I/O scheduler included in Linus' tree.

My first priority is to get that patch in order.

>
> Then you might perhaps schedule the Deadline I/O scheduler for removal.

what are people's thoughts on this?  since schedulers are modular, do
we need a scheduled removal, or can this just sit in -mm for a while?
if people are concerned about scripts which ask for 'deadline', we
could add another exception (like the as->anticipatory one).

NATE
