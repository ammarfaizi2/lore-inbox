Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTLDBmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLDBmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:42:11 -0500
Received: from mail.netzentry.com ([157.22.10.66]:62981 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S262913AbTLDBmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:42:06 -0500
Message-ID: <3FCE90CD.6060501@netzentry.com>
Date: Wed, 03 Dec 2003 17:41:33 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wa1ter@myrealbox.com
CC: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
 >>Josh McKinney wrote:
 >> To me the strangest thing is that when I first got this
 >>board a month or
 >> so ago it would hang with APIC or LAPIC enabled.  Now it works
 >>fine
 >> without disabling APIC.  All I did was update the BIOS and
 >>use it for a
 >> while with APIC disabled...
 >
 >Does the new BIOS use different defaults for memory timing,
 >bus speed, etc?
 >Did you change any of the default settings in the BIOS?
 >
-- I don't think this issue has anything to do with motherboard
maker or BIOS rev. Most of the people with this problem are
not overclocking and have stable machines with other OSes or
under certain conditions namely:

* In general NForce2 boards are stable under windows 2000
- a far as I can tell

* The boards are stable under certain conditions. The final
test for this (Proposed by Allen Martin
[AMartin at nvidia ! com] is to get a stable well supported
PCI-IDE add in card and ignore the "AMD/NVIDIA" IDE onboard.
(First pointed out by Ian Kumlien I believe)
"If we all have that, and deadlock when using the amd/nvidia
driver.. then we know that that might be the fault. The
machine still locks for a while so, it's not just the ide,
  but it might be a good place to start."

* NForce2 boards are stable when using APIC and using generic
IDE driver. This is painfully slow but is stable.

-- In general: I dont think it should be so easy to blame
the BIOS. If one isnt overclocking and using the SPD on the
memory and using conservative settings, what difference
should that make? And if the board is stable with another
OS I take this "BIOS blaming" and basically throw it out. BIOS
is a deprecated arcane ridiculous thing and should never be
trusted. I have seen on several nicer dual SCSI based
machines messages on boot about certain values being changed
or fixed up.

-- Fixing this for 2.4.x too is important so be sure to try
and find out if 2.4.23 hangs if you get a stable 2.6 thing
going.

Thanks everyone for your continued interest in this, I'll
try and test the no-onboard-PATA + UP LAPIC and IOAPIC and
add-in-card-PATA with no onboard PATA + + UP LAPIC and IOAPIC
when I get a spare moment which is rare.


PS: If you are being CCed and dont want to be, let me know
Some people arent on the list.


