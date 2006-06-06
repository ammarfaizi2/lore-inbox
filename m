Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWFFXRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFFXRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWFFXRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:17:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:3187 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751345AbWFFXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:17:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YGG0hFcOLR0W5xKTE3GEaQ88OTRTVYhE7nkjEsXII+FB9dt/RkTU1xX08nv5aGUaLv9CXdBAOLB25k9Oo2YrqrL+jox4OA0ygFafW+qAnC4q/4R2pV3uBEDGMnwdgOz+X8RQpRcyq7TnmXvMaP3C+/XzYc9Gd2zpcMpAR2rJnuw=
Message-ID: <44860CAC.90107@gmail.com>
Date: Wed, 07 Jun 2006 07:15:56 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com>	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>	 <4485DB6C.704@gmail.com>	 <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>	 <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com> <9e4733910606061455l2ab3a217q431a90a6c3555813@mail.gmail.com>
In-Reply-To: <9e4733910606061455l2ab3a217q431a90a6c3555813@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/6/06, Dave Airlie <airlied@gmail.com> wrote:
>> > > >
>> > How is the stack maintained of what was previously bound to console?
>> > What if I unbind fbcon on a system that doesn't have VGAcon for a
>> backup?
>>
>> You could try actually reading the patches...
> 
> I was working on a patch for this but now I've lost interest.

How come? I never believed you're the type to lose interest so easily :-)

> 
> Detach should be an attribute off from /dev/console. /dev/console is
> using the standard device support and appears at
> /sys/class/tty/console so /sys/class/tty/console/detach can be added
> as an attribute. /sys/class/tty/console could have another attribute
> which lists the available drivers. One solution would be for the
> attribute to list the names of the available drivers that have
> registered with console and then copy one of those names back to the
> attribute to select where console is bound.
> 
> In my opinion attach/detach does not belong as an attribute on fbcon,
> it is part of /dev/console. The fact that fbcon has to ask console to
> unbind from it implies these attributes are in the wrong place.

Okay, you and Andrew persuaded me to change the location of the control.
I did say that if someone makes the necessary change to the vt layer that
it won't be a problem. The necessary infrastructure is already introduced
by this patch to make it work like what you and Andrew want. 

Tony
 


