Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUIKIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUIKIin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUIKIin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:38:43 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:34794 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267796AbUIKIij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:38:39 -0400
Message-ID: <4142B987.5050808@tungstengraphics.com>
Date: Sat, 11 Sep 2004 09:38:31 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>	 <Pine.LNX.4.58.0409100209100.32064@skynet>	 <9e47339104090919015b5b5a4d@mail.gmail.com>	 <20040910153135.4310c13a.felix@trabant>	 <9e47339104091008115b821912@mail.gmail.com>	 <1094829278.17801.18.camel@localhost.localdomain>	 <9e4733910409100937126dc0e7@mail.gmail.com>	 <1094832031.17883.1.camel@localhost.localdomain>	 <9e47339104091010221f03ec06@mail.gmail.com>	 <1094835846.17932.11.camel@localhost.localdomain>	 <9e47339104091011402e8341d0@mail.gmail.com>	 <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain>
In-Reply-To: <1094853588.18235.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-09-10 at 23:19, Dave Airlie wrote:
> 
>>If the kernel developers can address this point I would be most
>>interested, in fact I don't want to hear any more about sharing lowlevel
>>VGA device drivers until someone addresses why it is acceptable to have
>>two separate driver driving the same hardware for video and not for
>>anything else.. (remembering graphics cards are not-multifunction cards -
>>like Christoph used as an example before - 2d/3d are not separate
>>functions...)...
> 
> 
> We've addressed this before. Zillions of drivers provide multiple
> functions to multiple higher level subsystems. They don't all have to
> be compiled together to make it work. 
> 
> 2D and 3D _are_ to most intents and purposes different functions. They
> are as different as IDE CD and IDE disk if not more so.

This depends to a great deal what you mean by 2D.  The idea of a blitter or 
dedicated 2D acceleration engine is rapidly becoming history.  Several cards 
currently ship without one, and I expect to see that become the norm in future.

But if you define 2D to include things like mode setting, etc, and not any 
acceleration, then the split sortof works.

It might be better to call the components different names, like 
"configuration" and "acceleration".

Keith




