Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVI3Q00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVI3Q00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVI3Q00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:26:26 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:64230 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030359AbVI3Q0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:26:24 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: dougg@torque.net
Cc: Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <433CE961.3040504@torque.net>
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
	 <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
	 <433CE961.3040504@torque.net>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:26:16 -0600
Message-Id: <1128097576.10079.88.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2005-09-30 at 17:29 +1000, Douglas Gilbert wrote:

snippage.

> 
> For SAS we have a well thought out definition for what the
> interface should be to hardware specific drivers IMO. It is
> called CSMI, rechristened SDI. The editor of SDI is also
> the editor of SAS, SAS-1.1 and SAS-2. Judging from his work,
> he knows his stuff. Unfortunately SDI uses ioctls to define
> its interface, which is mainly between two kernel layers
> (if one ignores pass throughs). 

I talked to one of the authors of these specs.  SDI is an attempt to
create an open standard for the somewhat proprietary CSMI spec developed
by HP.  It is currently languishing in t10 due to the IOCTL problem you
describe below (the "no new IOCTL's" doctrine caught them by surprise).
There is some thought to going to a write()/read() on a character device
model, but this has various problems as well.  

> Sorry, did I mention "ioctl",
> oh that makes SDI unacceptable. Almost a year ago that is what
> happened to the first proposed SAS driver for Linux. 

That was one of the reasons the MPT Fusion and Adaptec drivers were
rejected.  There were others as well, such as lack of a SAS transport
class.

Andrew

> That
> decision has pushed Luben (amongst others) into the position
> he is in now: come up with a "better" design, produce code
> and then watch it get rejected. So please cut Luben a bit
> of slack.
> 
> Just in case people think that I agree with Luben on using
> sysfs to represent the whole SAS topology and interesting
> bits suspended in it (i.e. SAS expanders), then I don't.
> I am, however, prepared to argue the detail. Since the
> days of Eric Youngdale I have believed that SCSI Host Bus
> Adapters (HBAs) should be addressable devices, just like
> network interfaces. IMO it is the block layer and its
> associated end devices that are the legacy thinking.
> 
> > There's an absolutely mindbogglingly huge difference between the two.
> 
> It is ironic that as the author of the SG_IO
> passthrough ioctl the "specs" that I am
> often asked to help circumvent are the "we
> know better" variety built into various layers
> of the linux kernel :-)
> 
> Doug Gilbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

