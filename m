Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWFKXrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWFKXrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWFKXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 19:47:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:47342 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWFKXrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 19:47:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FLBKMzH6qbTd+gZcaVbqley8dmc8+uLy1Wyx7ZsZ3nxqoOq3dMUi02b0Ezo/oP1iYgXm69TDrkt9nDt4358rUvFg4jpLs81bOSU8BNX5Im5BCfM6dtU4mXHzVRLJow913B2JkalgKa1/0h4qbVl5d2IOxfbxlyfoHaQhIlHWfLM=
Message-ID: <4745278c0606111647g7ca1392bjb46936f69d6b668d@mail.gmail.com>
Date: Sun, 11 Jun 2006 19:47:07 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>
In-Reply-To: <20060611185854.GF13556@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com>
	 <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
	 <20060611185854.GF13556@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan

I ran the performance benchmark on an IBM machine with the following
harddrive attached to it.

cat /proc/ide/hda/model
ST340014A

Also note the CSCAN implementation is using rbtrees due which the time
complexity of the different operations is O(log(n)) and not O(n) and
that might be the reason that we are getting good values for specially
in case of sequential writes and the random workloads.

I will try making measurements using 2.6.17-rc6-gitX until next weekend.
Thanks for help and inputs folks.

- Vishal

On 6/11/06, Jens Axboe <axboe@suse.de> wrote:
> On Fri, Jun 09 2006, Vishal Patil wrote:
> > The machine configuation is as follows
> > CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz
> > Memory: 1027500 KB (1 GB)
> > Filesystem: ext3
> > Kernel:   2.6.16.2
>
> You don't mention the storage used, which is quite relevant.
>
> If you have the time, please rerun with 2.6.17-rc6-gitX latest. Although
> I'm not sure why you think CSCAN is a good scheduling algorithm, in
> general it may be fine but there are trivial non-root 'dos' attacks. Any
> of the non-noop Linux io schedulers is a better choice imo.
>
> --
> Jens Axboe
>
>


-- 
Success is mainly about failing a lot.
