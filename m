Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWIUNjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWIUNjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIUNjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:39:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:24988 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWIUNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:39:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mPXU2600wJgfgPE+aBCGjTXP0hWzGYKagS4UF9HV3dq295ZTIm6sgVOWn9non9pmgoKgIWqJJgNIxm9dPn/1XaNJ0Q5jjyI39fdef8r0jdmgSQeH7URbuuvTKZi1s3h/rt2KFQqg7Bfg2bE3+e08fSZ6GLUTqXLd6LesZ2kFdpY=
Message-ID: <d120d5000609210639m5e7c4c2ctb1f23be64bb6b0c8@mail.gmail.com>
Date: Thu, 21 Sep 2006 09:39:40 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "James Bruce" <bruce@andrew.cmu.edu>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Marek Vasut" <marek.vasut@gmail.com>
In-Reply-To: <45124509.1050205@andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
	 <20060920215507.GM1153@redhat.com>
	 <200609202118.27741.dtor@insightbb.com>
	 <45124509.1050205@andrew.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, James Bruce <bruce@andrew.cmu.edu> wrote:
> Dmitry Torokhov wrote:
> > On Wednesday 20 September 2006 17:55, Dave Jones wrote:
> >> On Wed, Sep 20, 2006 at 05:29:43PM -0400, Dmitry Torokhov wrote:
> >>  > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
> >>  > > remove-silly-messages-from-input-layer.patch
> >>  >
> >>  > I firmly believe that we should keep reporting these conditions. This
> >>  > way we can explain why keyboard might be losing keypresses. I am open
> >>  > to changing the message text. Would "atkbd.c: keyboard reported error
> >>  > condition (FYI only)" be better?
> >>
> >> Q: What do you expect users to do when they see the message?
> >
> > A: Nothing. But when they tell me that sometimes they lose keystrokes I
> > can ask them if they see it in dmesg. And if they see it there is nothing
> > I can do. Again, if you could suggest a better wording that would not alarm
> > unsuspecting users that would be great.
>
> If it is needed only to answer "does my keyboard work", maybe you could
> store an error count in the driver, or put it to the event layer.
> Coupled with a way to retrieve the value (ioctl+evtest,proc,sys,etc),
> the user can get the information they need, but only when they actually
> want it.
>
> The networking subsystem seems to store a lot of its error conditions in
> proc-accessible counters rather than printing a warning.  Thus there is
> precedent for avoiding dmesg spam in this way.
>

That is actually a pretty good idea. I'll add a sysfs counter
attribute and remove that printk, unless there are objections.

-- 
Dmitry
