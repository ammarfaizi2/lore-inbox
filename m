Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285108AbRLFKwb>; Thu, 6 Dec 2001 05:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285109AbRLFKwV>; Thu, 6 Dec 2001 05:52:21 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:6150 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285108AbRLFKwR>; Thu, 6 Dec 2001 05:52:17 -0500
Message-Id: <5.0.2.1.0.20011206113115.00a53c10@pop.mail.yahoo.fr>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 06 Dec 2001 11:43:21 +0100
To: Dipak <dipak@monmouth.com>
From: Romain Giry <romain_giry@yahoo.fr>
Subject: Re: 
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0E90C0.A1738C8C@monmouth.com>
In-Reply-To: <5.0.2.1.0.20011205170157.01a7ae98@pop.mail.yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I'm doing a ethernet device
> > that doesn't add any header to the packet but change the output device,
> > then i should say the network device that the packet is like if it has been
> > sent by the ip protocol.
>
>I didn't understand what did you mean by "ethernet device doesn't add any
>header but change the output device"? May be after you explain a bit more I
>can suggest something more.


For my thesis, I should do a module for linux that allows the user to 
switch the
physical device at run-time. In a first time this should be done by user 
commands
and later the module should decide himself to switch the physical device.

That's why it seems to me natural to create a dummy ethernet device driver 
which
does nothing else apart from forwarding the packets received from the IP stack
to a real (= physical) network device. Therefore i need to fake that the 
packet was
sent by the IP stack so as the physical device fill in correctly the 
protocol field in
the header it adds.

Otherwise i thought i can do a transparent firewall that decides to which real
interface to switch the packets after beeing sure that the physical device is
running otherwise it should change.

One thing that may be difficult to implement is that i want to keep a TCP
connection running when i change the physical device. That's why maybe the
firewall solution may be better because when receiving packets i could fake
that they all come from the same physical device and have therefore the same
IP.

Thanks

Romain


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

