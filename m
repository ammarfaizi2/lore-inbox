Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWCaOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWCaOQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCaOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:16:22 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:23140 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751307AbWCaOQV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:16:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uB/UKS2IVaJxdOdGmMx+bt87jewsOxbB8gDA/G8EK+lFdM9GPyFQix1oO6W8o7BKp7ufLvfEUaQhOiuQAhJZ6ZOlEQqUHkF8eZctV3kIIhoOH4/98tklUFiq0TGcKcRRXpE3GT8fkyMIul4cQhKRx9MbWdits8zbjkvfW4Th8D0=
Message-ID: <4745278c0603310616g23a3345dt31e9deab5ab22bae@mail.gmail.com>
Date: Fri, 31 Mar 2006 09:16:20 -0500
From: "Vishal Patil" <vishpat@gmail.com>
To: lkml@lpbproductions.com
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603310128.36991.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
	 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
	 <200603310128.36991.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will post a patch for the 2.6.16 kernel over this weekend.

- Vishal

On 3/31/06, Matt Heler <lkml@lpbproductions.com> wrote:
> Any chance you can diff this against the latest 2.6 kernel ? 2.6.10 is abit
> old.
>
> Thanks
>
> On Thursday 30 March 2006 10:58 pm, Vishal Patil wrote:
> > Maintain two queues which will be sorted in ascending order using Red
> > Black Trees. When a disk request arrives and if the block number it
> > refers to is greater than the block number of the current request
> > being served add (merge) it to the first sorted queue or else add
> > (merge) it to the second sorted queue. Keep on servicing the requests
> > from the first request queue until it is empty after which switch over
> > to the second queue and now reverse the roles of the two queues.
> > Simple and Sweet. Many thanks for the awesome block I/O layer in the
> > 2.6 kernel.
> >
> > - Vishal
> >
> > PS: Please note that I have not subscribed to the LKML. For comments
> > please reply back to this email.
> >
> > --
> > Every passing minute is another chance to turn it all around.
>


--
Every passing minute is another chance to turn it all around.
