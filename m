Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFXPzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFXPzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:55:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262253AbTFXPzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:55:39 -0400
Subject: Re: 2.5.7[23]: wall-clock time advancing too rapidly?
From: Andy Pfiffer <andyp@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andreas Haumer <andreas@xss.co.at>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056415040.1028.82.camel@w-jstultz2.beaverton.ibm.com>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at> <1056151705.1162.114.camel@andyp.pdx.osdl.net>
	 <1056154072.1027.13.camel@w-jstultz2.beaverton.ibm.com>
	 <1056413771.1209.14.camel@andyp.pdx.osdl.net>
	 <1056415040.1028.82.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056470943.1209.38.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 09:09:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 17:37, john stultz wrote:
> On Mon, 2003-06-23 at 17:16, Andy Pfiffer wrote:
> > Hmmm... I tried the patch in 2.5.73 and it appeared to have no effect.
> 
> Ah, just when I sent it off to Andrew. Well, I've been getting a number
> of successful reports, so its still good to give it further testing. 

Yeah, I saw that.  Same time in my inbox, too. ;^)

> Looking over it again you're still not showing any of the signs of
> changing cpu-frequency. But the symptoms are very similar. I'm curious,
> this is the x220? Do you have a service processor installed in that box?
> Maybe we're running into some sort of SMI trouble?

It says on the front of the case "IBM eserver", but the "e" sort of
looks like an "@".  Also printed on the front of the case is "x220."

I have no idea if there is a service processor installed in the box.

Here is the output of lspci:

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
04)
01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)

There is a 2nd Intel e100 interface on the motherboard ("planar" in
IBM-speak), but that has been set to "disabled" in the BIOS for some
reason.  Re-enabling it has no effect on the time skew, nor does the USB
legacy support that worked for someone else on a different system.

Strange, huh?



