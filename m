Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbSJAPan>; Tue, 1 Oct 2002 11:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261680AbSJAPan>; Tue, 1 Oct 2002 11:30:43 -0400
Received: from [202.64.97.34] ([202.64.97.34]:21254 "EHLO main.coppice.org")
	by vger.kernel.org with ESMTP id <S261674AbSJAPal>;
	Tue, 1 Oct 2002 11:30:41 -0400
Message-ID: <3D99C0D9.7060704@coppice.org>
Date: Tue, 01 Oct 2002 23:35:53 +0800
From: Steve Underwood <steveu@coppice.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020911
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
References: <3D90831A.7060709@coppice.org> <20020924162130.GE9457@redhat.com> <3D91BF58.8080803@coppice.org> <20020925142757.GL9457@redhat.com> <20020925150129.GC30339@kroah.com> <20020925150915.GM9457@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:

>On Wed, Sep 25, 2002 at 08:01:29AM -0700, Greg KH wrote:
>
>  
>
>>I understand that the uss720 driver should register with parport, as
>>it is a USB to parallel port adapter, but the usblp driver should
>>not, as it is just a pass-through to a printer.  Do you see any
>>advantage to having usblp registering with parport?
>>    
>>
>
>Well, it would mean that ppdev could use it.  I understand that only a
>few functions of a normal parallel port could be implemented (read,
>write, get status).
>
>Alternatively I suppose I could get libieee1284 to grok /dev/usb/lp*.
>Steve---would that solve the problem that you're running into?
>
>Tim.
>*/
>  
>
Well, the application is this. A lot of industrial control, embedded 
processor development interfaces, and other stuff use a parallel port to 
connect to a PC. The parallel port has gone from some notebooks, and is 
soon to go from desktops too. I want to access some of those devices 
through a USB to IEEE1284 cable. If the programming interface is ppdev, 
that is great - no changes needed for code that already works with a 
real parallel port. If it requires a somewhat different API, that's no 
big deal. Being able to bit twiddle to the extent that ppdev allows is 
pretty important, though. I guess there may be some latency issues 
slowing the bit twiddling across a USB interface, but nothing's perfect.

Regards,
Steve


