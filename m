Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTEaDPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 23:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTEaDPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 23:15:21 -0400
Received: from main.gmane.org ([80.91.224.249]:6051 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264122AbTEaDPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 23:15:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
Date: Fri, 30 May 2003 23:28:35 -0400
Message-ID: <pan.2003.05.31.03.28.35.443354@interlinx.bc.ca>
References: <Pine.GSO.3.96.1021108131625.3217B-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.44.0211080804280.27141-100000@montezuma.mastecende.com> <15819.47795.543312.435264@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Nov 2002 14:22:59 +0100, Mikael Pettersson wrote:
> 
> People with broken boxes should send their DMI data to me so I can add
> their boxes to the local APIC blacklist in dmi_scan.c.

That was the approach I wanted to use in the first place to deal with the
broken local apic in vmware 2.0.4.  See the thread (which is unfortunately
broken -- the followup must not have included a References: header back to
the my original message):

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0907.html

The thread can be picked up again in this message: 

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0995.html

> "nolapic" is
> simply a workaround for the absence of this DMI data.

Unfortunately, VMware 2.0.4 does not have any DMI data to identify it by. 
the search for _DMI_ between 0xF0000 and 0xFFFFF finds nothing.  I dunno
if this is valid for proving or disproving the presence of DMI data, but:

# dmidecode
# dmidecode 1.8
BIOS32 Service Directory present.
        Calling Interface Address: 0x000FD8C0
PNP 1.0 present.
        Event Notification: Not Supported
        Real Mode Code Address: F000:AEA5
        Real Mode Data Address: 0040:0000
        Protected Mode Code Address: 0x000FAEC3
        Protected Mode Data Address: 0x00000400
PCI Interrupt Routing 1.0 present.
        Table Size: 0 bytes
        Router ID: ff:1f.7
        Exclusive IRQs: None

> Notice how silent the Inspiron 8k users are now that the DMI black
> list is implemented...

:-)  I like the approach, it just doesn't always apply, thus the need for
kernel commandline args.

b.


