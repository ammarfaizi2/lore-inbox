Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbQKPSZw>; Thu, 16 Nov 2000 13:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQKPSZm>; Thu, 16 Nov 2000 13:25:42 -0500
Received: from cs.utexas.edu ([128.83.139.9]:13522 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S130112AbQKPSZZ>;
	Thu, 16 Nov 2000 13:25:25 -0500
Date: Thu, 16 Nov 2000 11:55:24 -0600 (CST)
From: Nishant Rao <nishant@cs.utexas.edu>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Setting IP Options in the IP-Header
In-Reply-To: <20001116181840.A18222@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0011161136160.5903-100000@crom.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, while what you say makes sense, it isn't exactly a solution to our
problem.

we are trying to expose and set a NEW option altogether. So our question 
pertains more to what code we write in the kernel to create and expose a 
new custom option. so for this, we would need to know the offsets of the
current options like source routing etc and then hopefully try and stuff
data from setting our option after the maximum that can be set by these
other existing options.

once that code is in place within the ip_build_options routine in the
ip_options.c file in the linux kernel, we can then use the setsockopt() 
at the application level to make sure that a packet is filled with the
corresponding option.

i hope i was able to explain my question more clearly.

thanks for your help !

nishant

On Thu, 16 Nov 2000, Andi Kleen wrote:

> On Thu, Nov 16, 2000 at 11:11:45AM -0600, Nishant Rao wrote:
> > Hi,
> > 
> > We are conducting some research that involves setting our custom data as
> > a new IP option in the IP header (in the options field) of every packet.
> > 
> > We have poured over the source code but it is quite confusing to figure
> > out how the details of the way the options field is split among various
> > options (ie. offsets etc). Can anyone help us figure out how to add new
> > custom options into the IP header ? 
> 
> man ip(7), see the IP_OPTIONS socket option.
> 
> Linux only echoes received options, but never sets them by default unless that 
> socket option is specified. So it depends on the application and/or the sender.
> 
> -Andi
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
