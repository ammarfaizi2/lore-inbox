Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUIKRwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUIKRwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIKRuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:50:11 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:64942 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268248AbUIKRty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:49:54 -0400
Date: Sat, 11 Sep 2004 13:49:34 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094919630.21082.116.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409111346170.15792@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet>  <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.58.0409110600120.26651@skynet>  <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com> 
 <1094913414.21157.65.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com> 
 <1094915671.21290.77.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com>
 <1094919630.21082.116.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Alan Cox wrote:

> On Sad, 2004-09-11 at 18:10, Vladimir Dergachev wrote:
>> This is a good point - if we don't need DMA or 3d acceleration we can
>> reduce memory footprint. This would seem that current DRM driver would
>> need to be dependent on whatever driver contains the mode setting code.
>>
>> What do you think ?
>
> Jon wants to get mode setting into a seperate piece of functionality -
> preferably in user space for many cards. I'd dearly love to see hotplug
> handing all but some "emergency" pre-computed mode settings.

I think there is a misunderstanding.

My view was that PLL setting (and setting of a fixed mode) would be done 
in DRM driver. This way it would be able to restore previous settings 
after a lockup or respond to FB request to change modes.

However the decision of which mode to set, as well as where the 
framebuffer is located is done in user-space. (So that subtleties of
layout of offscreen memory are not in the kernel).

Jon - did I understand you correctly ?

                             best

                               Vladimir Dergachev
