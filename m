Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVCBE5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVCBE5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 23:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCBE5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 23:57:13 -0500
Received: from nemesis.fprintf.net ([66.134.112.218]:48056 "EHLO
	nemesis.fprintf.net") by vger.kernel.org with ESMTP id S262171AbVCBE4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 23:56:54 -0500
Subject: Re: Complicated networking problem
From: Daniel Gryniewicz <dang@fprintf.net>
To: Jarne Cook <jcook@siliconriver.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503021327.31429.jcook@siliconriver.com.au>
References: <200502281459.31402.jcook@siliconriver.com.au>
	 <200503010202.j2122b80025303@turing-police.cc.vt.edu>
	 <200502282135.35405.dtor_core@ameritech.net>
	 <200503021327.31429.jcook@siliconriver.com.au>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 23:56:50 -0500
Message-Id: <1109739410.11773.0.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 13:27 +1000, Jarne Cook wrote:
>On Tuesday 01 March 2005 12:35, you wrote:
>> On Monday 28 February 2005 21:02, Valdis.Kletnieks@vt.edu wrote:
>> > On Mon, 28 Feb 2005 14:59:31 +1000, Jarne Cook said:
>> > > They are both using dhcp to the same simple network.  That's right. 
>> > > Same network.  They both end up with gateway=192.168.0.1,
>> > > netmask=255.255.255.0. But ofcourse they do not have the same IP
>> > > addresses.
>> >
>> > I don't suppose your network people would be willing to change it thusly:
>> >
>> > wired ports:  gateway 192.168.0.1, netmask 255.255.255.128.0
>> > wireless:     gateway 192.168.128.1, netmask 255.255.255.128.0
>> >
>> > Or move the wireless up to 192.168.1.1 if they think that would confuse
>> > things too much.
>> >
>> > There's a limit to how far we should bend over backwards to support
>> > stupid networking decisions. 192.168 *is* a /16, might as well use it. ;)
>> >
>> > If they won't, you're pretty much stuck with binding applications to one
>> > interface or another.
>>
>> If the goal is to primarily use wired link and seamlessly swith to wireless
>> then look into bonding driver in failover mode with wired interface as
>> primary. This way you have only one address and userspace does not notice
>> anything.
>
>Damn
>
>Having to configure the interfaces using bonding was not really the answer I 
>was expecting.
>
>I did not think linux would be that rigid.  I figured if poodoze is able to do 
>it (seamlessly mind you), surely linux (with some tinkering) would be able to 
>do it also.
>
>The goal was to have the networking on the laptop work as perfectly as 
>crapdoze does.  
>
>Perhaps I should and this topic to my list of software issues that no-one else 
>cares about. "man that list is getting big".  maybe one day I'll develop the 
>balls to get deep into the code.
>
>

Check out NetworkManager.  It will do what you want.

Daniel

