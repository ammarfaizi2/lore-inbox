Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSIYAFp>; Tue, 24 Sep 2002 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSIYAFp>; Tue, 24 Sep 2002 20:05:45 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:2511 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261860AbSIYAFo>;
	Tue, 24 Sep 2002 20:05:44 -0400
Message-ID: <3D90FED3.5060705@candelatech.com>
Date: Tue, 24 Sep 2002 17:09:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Brad Hards <bhards@bigpond.net.au>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C4FE.3070909@pobox.com> <3D90D0FB.1070805@sun.com> <200209250832.35068.bhards@bigpond.net.au> <3D90F5D3.4070504@pobox.com> <3D90F78E.1060405@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:

> a single device_event file that a daemon reads and dispatches events (I 
> like this one because the daemon is already written, just poorly named - 
> acpid)

Couldn't you just have the message sent to every process that has
opened the file (and have every interested process open the file and
read it in a non-blocking or blocking mode?)

That seems to negate the need for something like acpid, but it does
not preclude it's use.

> 
> For things like netif_carrier, poll() is probably best - the DHCP client 
> can be fully self contained, and not need an eventd to alert it to a 
> signal change.  Of course, acpid does support UNIX socket connections 
> from apps like DHCP....

I would prefer an event, and it can still be self contained if my
idea above is actually workable.

Ben

> 
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


