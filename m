Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbULFWUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbULFWUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbULFWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:20:50 -0500
Received: from 209-128-68-124.BAYAREA.NET ([209.128.68.124]:51393 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261680AbULFWUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:20:42 -0500
Message-ID: <41B4DB1C.3060406@zytor.com>
Date: Mon, 06 Dec 2004 14:20:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dynamic syscalls revisited
References: <1101741118.25841.40.camel@localhost.localdomain>	 <20041129151741.GA5514@infradead.org>	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>	 <cp2i3h$hs0$1@terminus.zytor.com> <1102370517.25841.216.camel@localhost.localdomain>
In-Reply-To: <1102370517.25841.216.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> I disagree about this statement.  ioctl's suck because they usually have
> none, or very poor documentation and you are stuck with opening devices,
> and sending parameters to them that may be for the wrong device and
> there is really no good checking to see what you sent is what you want
> since its all defined by human unreadable numbers.
> 

That's like saying you might be calling the wrong syscall by accident.

> As for dynamic system calls (and especially the way I've implemented
> them) you have human readable names, with varying amount of parameters
> that can make sense. So even if you still have none to very poor
> documentation, you can understand things perhaps a little better.  There
> is also much better checking in dynamic system calls than to ioctls.

There is NO checking in the syscall interface.  Period.  Any such 
checking is a facility of some kind of stub generator, and that's 
independent of the method used to invoke it.

	-hpa




