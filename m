Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbUAZXnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAZXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:43:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:31498 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265624AbUAZXlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:41:31 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: 26 Jan 2004 23:41:13 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv48ip$70t$1@gatekeeper.tmr.com>
References: <200401251137.21646.p_christ@hol.gr>
X-Trace: gatekeeper.tmr.com 1075160473 7197 192.168.12.62 (26 Jan 2004 23:41:13 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200401251137.21646.p_christ@hol.gr>,
P. Christeas <p_christ@hol.gr> wrote:
| This may be just a minor issue:
| I had to use the setkeycodes utility to enable some extra keys (that weren't 
| mapped by kernel's atkbd tables).
| After waking from sleep 1, those keys were reset. That is, I had to use 
| 'setkeycodes' again to customize the tables again.
| 
| IMHO the way kernel works now is correct. It should *not* have extra code just 
| to handle that. Just make sure anybody that alters his kbd tables puts some 
| extra script to recover the tables after an ACPI wake.
| This should be more like a note to Linux distributors.

I'm not totally sure I agree that the kernel should save this
information. With all the things the kernel does save, keyboard might be
a good thing. Consider someone with a REALLY hacked layout, like
modified dvorak or some of the keyboards for the access challenged. Now
think "can't use the keyboard enough to type in the ...ing commands to
do the load."

If we can carry the code for two competing disfunctional ACPI
implementations and a used-to-work but we broke it for some machines
APM, we can surely add a pair om memcpy lines to eliminate at least one
"oh-shit moment."

Obviously my opinion only, some breakage due to BIOS misfeatures,
contents may settle in shipping, etc.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
