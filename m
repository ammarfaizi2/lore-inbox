Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289310AbSA1SYK>; Mon, 28 Jan 2002 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSA1SYA>; Mon, 28 Jan 2002 13:24:00 -0500
Received: from mail.myrio.com ([63.109.146.2]:48633 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S289310AbSA1SXt> convert rfc822-to-8bit;
	Mon, 28 Jan 2002 13:23:49 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.2.20: pci-scan+natsemi & Device or resource busy
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Mon, 28 Jan 2002 10:22:22 -0800
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB45@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.2.20: pci-scan+natsemi & Device or resource busy
Thread-Index: AcGmw0glyjcB+HrIRp6SBoXhLVL7lgBY0hxw
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Stevie O" <stevie@qrpff.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You have probably learned this by now, but I haven't seen anyone
say it on the list, so I'll summarize...

The 2.2.x kernels did not come with drivers for the natsemi.  The 
Donald Becker / Scyld add-on drivers were much better than nothing, 
and we were grateful to have them, but they don't work reliably for 
our hardware.  We are using motherboards with a soldered-on natsemi
chip, not the Netgear FA-311.  We did hack up a version of the 
driver that worked for us under 2.2.19, and you can get it from 
www.myrio.com/opensource if you are interested.

However, the 2.4.x kernels come with much improved natsemi drivers. 
These are Donald Becker's drivers, still copyright by him, but have 
been updated a lot for 2.4 with new PCI code and lots of bugfixes.

For our hardware, the 2.4.x drivers work quite well as delivered in
the tarball.  

I'm actively working to track down intermittent and hard-to-reproduce 
problem with multicast receive, but normal one-to-one ethernet seems 
to work perfectly.

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com


> -----Original Message-----
> From: Stevie O [mailto:stevie@qrpff.net]
> Sent: Saturday, January 26, 2002 3:37 PM
> To: linux-kernel@vger.kernel.org
> Subject: 2.2.20: pci-scan+natsemi & Device or resource busy
> 
> 
> My friend is trying Linux for the first time. I'm having him use the 
> pci-scan and natsemi modules for his Netgear FA-311 card. 
> With the initial 
> download and compile and insmod, he got that wonderful message:
> 
> natsemi.o: init_module: Device or resource busy
> 
> He was using 2.2.13, so I got him to upgrade to 2.2.20 to see 
> if that might 
> have fixed some problem. However, the problem still hasn't 
> gone away :(
> No amount of googling has revealed a solution to the problem, 
> since which 
> I've discovered that "Device or resource busy" is an 
> extremely vague error 
> message.
> 
> Please help!
