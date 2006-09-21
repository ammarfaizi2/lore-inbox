Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIUHxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIUHxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWIUHxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:53:55 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:47850 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751016AbWIUHxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:53:54 -0400
Message-ID: <45124509.1050205@andrew.cmu.edu>
Date: Thu, 21 Sep 2006 03:53:45 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marek Vasut <marek.vasut@gmail.com>
Subject: Re: 2.6.19 -mm merge plans (input patches)
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com> <20060920215507.GM1153@redhat.com> <200609202118.27741.dtor@insightbb.com>
In-Reply-To: <200609202118.27741.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday 20 September 2006 17:55, Dave Jones wrote:
>> On Wed, Sep 20, 2006 at 05:29:43PM -0400, Dmitry Torokhov wrote:
>>  > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
>>  > > remove-silly-messages-from-input-layer.patch
>>  > 
>>  > I firmly believe that we should keep reporting these conditions. This
>>  > way we can explain why keyboard might be losing keypresses. I am open
>>  > to changing the message text. Would "atkbd.c: keyboard reported error
>>  > condition (FYI only)" be better?
>>  
>> Q: What do you expect users to do when they see the message?
> 
> A: Nothing. But when they tell me that sometimes they lose keystrokes I
> can ask them if they see it in dmesg. And if they see it there is nothing
> I can do. Again, if you could suggest a better wording that would not alarm
> unsuspecting users that would be great.

If it is needed only to answer "does my keyboard work", maybe you could 
store an error count in the driver, or put it to the event layer. 
Coupled with a way to retrieve the value (ioctl+evtest,proc,sys,etc), 
the user can get the information they need, but only when they actually 
want it.

The networking subsystem seems to store a lot of its error conditions in 
proc-accessible counters rather than printing a warning.  Thus there is 
precedent for avoiding dmesg spam in this way.

Just my $0.02

  - Jim Bruce
