Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUIKSGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUIKSGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUIKSGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:06:48 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:27798 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268240AbUIKSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:06:20 -0400
Date: Sat, 11 Sep 2004 14:05:54 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e473391040911105942f52db6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0409111405140.15792@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409110600120.26651@skynet>  <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com> 
 <1094913414.21157.65.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com> 
 <1094915671.21290.77.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com> 
 <1094919630.21082.116.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111346170.15792@node2.an-vo.com> <9e473391040911105942f52db6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Jon Smirl wrote:
>>
>> My view was that PLL setting (and setting of a fixed mode) would be done
>> in DRM driver. This way it would be able to restore previous settings
>> after a lockup or respond to FB request to change modes.
>>
>> However the decision of which mode to set, as well as where the
>> framebuffer is located is done in user-space. (So that subtleties of
>> layout of offscreen memory are not in the kernel).
>>
>> Jon - did I understand you correctly ?
>
> All register writes would occur in the driver. There is nothing
> stopping the code that computes those register values from running in
> user space.
>
> A example mode setting IO would take:
>  display buffer offset
>  width, height, stride, etc - for fbcon to use
>  register values to set the mode
>
> Mode setting needs to be serialized. It may be better to do the
> serialization before the hotplug event, in that case the mode setting
> IOCTL would be implicitly serialized and not need a separate lock.

Just to clear up things - do you plan to retain the knowledge of last mode 
set in the DRM driver ?

                            best

                              Vladimir Dergachev



>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
>
