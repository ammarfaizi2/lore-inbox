Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTH0NiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTH0NiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:38:09 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:21937 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S263336AbTH0NiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:38:04 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: Linux and PCI bridge
Date: Wed, 27 Aug 2003 09:51:21 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGEEDNCEAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC your response.

We are currently debugging a problem involving 2 PCI boards that we have
developed.  Our system eventually "hangs" after running for awhile.  By this
I mean that no hardware interrupts can get through (keyboard, mouse,
ethernet, etc.).  However, software components are still running.  During
this process I added some debug software and have determined that individual
IRQs were not disabled at the 8259 interrupt controller.  I have also
determined that interrupts are still on at the processor - so there was not
a naughty piece of software that did a "cli" and forget to clean up after
itself.  Something is getting hosed in the hardware and interrupts are not
able to get from our PCI device to my driver.  We have confirmed that our
device has it's interrupt asserted when it hangs.  That makes the PCI bus,
bridge and Front Side Bus the suspects in this.

So, my questions to you are:

- Can anyone recommend any tools that would be useful in debugging this?
I've started looking at a couple of PCI bus analyzers, but I'm not sure that
it will allow me to detect anything with respect to the bridge or the FSB.

- Other than the handling of 8259 and APIC interrupts (BTW, we don't use
APIC), does the Linux O/S drive anything else in the bridge, or is this a
BIOS thing?

We have tried other slots, exclusive interrupt use and updates to BIOS.  At
one point, I thought it was an APM related bug in the BIOS because we
experienced no failures once we told it to NOT issue CPU idle calls.   Since
we don't need power management, we turned it off completely.  However,
testing of our second product has not gone as well.  We experience the same
symptoms.

Thanks in advance for your help.



Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



