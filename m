Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTLHHNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 02:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTLHHNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 02:13:04 -0500
Received: from ns0.asml.nl ([194.105.121.194]:60156 "EHLO nlvdhx10.asml.nl")
	by vger.kernel.org with ESMTP id S264567AbTLHHNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 02:13:00 -0500
From: Tim Timmerman <Tim.Timmerman@asml.com>
Message-ID: <16340.9329.913657.900605@asml.com>
Date: Mon, 8 Dec 2003 08:12:49 +0100
To: "Mark Symonds" <mark@symonds.net>, linux-kernel@vger.kernel.org
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <008501c3bd18$697361e0$7a01a8c0@gandalf>
References: <Pine.LNX.4.44.0312071236430.1283-100000@logos.cnet>
	<008501c3bd18$697361e0$7a01a8c0@gandalf>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-NAIMIME-Disclaimer: 1
Content-Type: Text/Plain
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mark" == Mark Symonds <mark@symonds.net> writes:

Mark> Hi,

>> 
>> The first oops looks like:
>> 
>> Unable to handle kernel NULL pointer
>> dereference at virtual address: 00000000
>> 
Mark> [...]

Mark> I'm using ipchains compatability in there, looks like 
Mark> this is a possible cause - getting a patch right now,
Mark> will test and let y'all know (and then switch to 
Mark> iptables, finally). 
      Let me just add a me-too here. 

      Haven't got the oops on my desk, here, but from what I could
      see, the error occurred in find_appropriate_src, somewhere in
      ipchains.  

      Further, possibly irrelevant datapoint: ABIT BP6, ne2k-pci and
      3Com590 network cards. When the oops occurs, everything locks,
      capslock and scrolllock are lit. 

      I can reproduce the error by letting a second system ping the
      first, on the internal network. Sometimes it doesn't even
      complete a full boot. 
      
      I'll try and capture more detail tonight. 

      TimT.

-- 
tim.timmerman@asml.nl                              040-2683613
timt@timt.org   Voodoo Programmer/Keeper of the Rubber Chicken
One time I went to a museum where all the work in the museum had been
done by children. They had all the paintings up on refrigerators. 



-- 
The information contained in this communication and any attachments is confidential and may be privileged, and is for the sole use of the intended recipient(s). Any unauthorized review, use, disclosure or distribution is prohibited. If you are not the intended recipient, please notify the sender immediately by replying to this message and destroy all copies of this message and any attachments. ASML is neither liable for the proper and complete transmission of the information contained in this communication, nor for any delay in its receipt.

