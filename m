Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDELs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDELs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 07:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWDELs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 07:48:57 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:11478 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751223AbWDELs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 07:48:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kr6tEyZWI4BkQngnyee5TKoVzSTRCWu+xZBWz7rlC9RkzJMh25e1p3ei5Crzv8sC/LaFq/35Wivdqy82++bJeQ7RTk9MnIKWC4TYjbNK8cI+yK7QgcDzjk8a5E5E+2PDI6/tgP5hnOXehl/36+JDyfEYHdAGOjS+FMHwuB8PB1A=
Message-ID: <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com>
Date: Wed, 5 Apr 2006 13:48:55 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Vishal Patil" <vishpat@gmail.com>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Cc: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com>
	 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com>
	 <4432D6D4.2020102@tmr.com>
	 <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/06, Vishal Patil <vishpat@gmail.com> wrote:
> In that case it would be a normal elevator algorithm and that has a
> possiblity of starving the requests at one end of the disk.
>
> - Vishal
>
> On 4/4/06, Bill Davidsen <davidsen@tmr.com> wrote:
> > Vishal Patil wrote:
> > > Maintain two queues which will be sorted in ascending order using Red
> > > Black Trees. When a disk request arrives and if the block number it
> > > refers to is greater than the block number of the current request
> > > being served add (merge) it to the first sorted queue or else add
> > > (merge) it to the second sorted queue. Keep on servicing the requests
> > > from the first request queue until it is empty after which switch over
> > > to the second queue and now reverse the roles of the two queues.
> > > Simple and Sweet. Many thanks for the awesome block I/O layer in the
> > > 2.6 kernel.
> > >
> > Why both queues sorting in ascending order? I would think that one
> > should be in descending order, which would reduce the seek distance
> > between the last i/o on one queue and the first on the next.
> >

But, if there are two queues, one which is being processed and other
which gets the new requests (and the corresponding queue switch when
the current is empty), then there is no way to get starved when they
are sorted in opposite order.


--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
