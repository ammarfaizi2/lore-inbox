Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbSJVOrV>; Tue, 22 Oct 2002 10:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSJVOrV>; Tue, 22 Oct 2002 10:47:21 -0400
Received: from pcp470010pcs.westk01.tn.comcast.net ([68.47.207.140]:44445 "EHLO
	shed.7house.org") by vger.kernel.org with ESMTP id <S263711AbSJVOrU>;
	Tue, 22 Oct 2002 10:47:20 -0400
Message-ID: <3DB56666.74ADDCB2@y12.doe.gov>
Date: Tue, 22 Oct 2002 10:53:26 -0400
From: David Dillow <dillowd@y12.doe.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C990 NIC
References: <1035002976.3086.4.camel@maranello.interclypse.net> <3DB4D9F8.F86ABA4@y12.doe.gov> <3DB51EA2.5060106@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> David Dillow wrote:
> > I have a completely reworked version that I expect to be able to release RSN.
> > (I know, I know, some of you have heard that before... it just takes time to
> > get people around here to sign off on these things. :/)

> Will you be submitting this for inclusion in the kernel?

Yes, I plan to run it by you first, and then once it is in shape, have it
included. 3Com has agreed to release their firmware binary under a BSD license
so that we can include it. (No source code, unfortunately.)

> And, what differences exists between the 3c59x and 3c90x hardware, and
> 3c990?  Just IPSEC?

Not really sure, ethernet hardware wise -- the driver communicates with an
onboard ARM chip, which we have to load firmware for. We then communicate with
it via several rings for commands, Tx packets, Rx packets, etc. There is an
onboard random number generator and crypto chip. We never drive the real
hardware directly, just talk to the firmware, which still has a few issues
that I am working with 3Com to resolve.

The nice thing about the firmware setup is that we don't really care which
card in the 3c990 family we're talking to per se -- they can change the
hardware all they want, and the driver should just work as long as we have
recent firmware. I currently support every version I know about:
3C990-{TX,SVR,B,M}-{,95,97}.

To set a date for this current vaporware -- I expect to have it to before the
end of November, and potentially much sooner. We have a conference just after
Thanksgiving, and our sponsors are itching to be able to say to those
attending that we've published this.

Dave
