Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUIKPxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUIKPxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUIKPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:53:53 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:19657 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268175AbUIKPxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:53:50 -0400
Date: Sat, 11 Sep 2004 11:53:31 -0400 (EDT)
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
In-Reply-To: <1094913414.21157.65.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Thus at the very least you would want to mandate the availability of mode
>> setting part of FB when DRM is loaded - and they you can just as well link
>> the relevant code together.
>
> You are making a generic assumption for a single card specific problem
> in a specific situation. That leads to bad decisions for embedded. It
> does argue for mode setting and fb to be separate too.
>
> (Remember for most embedded devices mode setting code is trivial)
>

Alan,

     My point was that you would want to have DRM working on Radeon cards,
right ? And there are complexities of current Radeon hardware that one 
would have to deal with, no matter how simple it might be to do the same 
thing for embedded.

     Lastly, I am not saying you have to put all the code in the same file.
All I am saying we can mandate that all Radeon HW specific code is linked
in one module - and this would make things easier for developers.

     Alternatively, you can have a complicated scheme whereby you load FB 
and DRM drivers in any order. But DRM would want FB (or part of it) to be 
present anyway so it should be able to recover from engine lockup.

     I would agree that this can be coded as well - but why bother ? Or is 
it done and working already ?

                         best

                           Vladimir Dergachev
