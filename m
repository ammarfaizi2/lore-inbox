Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbTGaTFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTGaTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:05:34 -0400
Received: from dp.samba.org ([66.70.73.150]:972 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267471AbTGaTFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:05:24 -0400
Date: Thu, 31 Jul 2003 19:05:21 +0000
From: crh@samba.org
To: linux-kernel@vger.kernel.org
Subject: Follow-up: Linux, Dell Access Point, and the GPL.
Message-ID: <20030731190521.A29009@dp.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apology: I'm not subscribed to the LKML, so please CC me on any replies.]

Last June, Colm MacCárthaigh reported that he had requested the Linux
kernel sources used to build the kernel for the Dell 1184 wireless access
point.  Dell responded by sending a CD containing "vanilla Linux 2.2.14
with the 2.2.14-rmk4 patch".  (See: http://lkml.org/archive/2003/6/8/76/)
That code is now included on the CDs that Dell distributes with the 1184     
APs.

As it turns out, however, that is not the correct kernel source.  The ARM
chip in the Dell 1184 is an ARM7TDMI, which has no MMU.  It is likely that
the 1184 kernel is originally based on uClinux.  It's certainly not
2.2.14-rmk4.

It appears, currently, as though Dell are the unlucky ones caught in the
middle.  The folks I've spoken with at Dell were not aware that the
product was even running Linux.

We've been discussing this on the LinuxAP-Dev mailing list.  (See:
http://ksmith.com/pipermail/linuxap-dev/2003-July/thread.html)  Here's
what we've determined so far:

Logging in to the 1184 via the TTL serial connection or telnet via port
333, we can run "sysconf view", which lists the manufacturer as "Gemtek
Taiwan".

The source for vLinux, as Colm reported, is On Software International of
Taiwan (previously known as OnLinux Technology Corp.).  It appears that
they are partnered with Vital Systems, Inc., of South Korea.  Vital
Systems is probably the producer of the development boards used for design
and for testing the software used in the APs.

  On Software is here: http://www.onsoftwarei.com/
Vital Systems is here: http://www.armlinux.net/
The likely development
        board is here: http://www.armlinux.net/Eng/solution/vls_4510_ap.htm

I have sent a request to Vital Systems to ask about obtaining a
development kit, but have had no response.  Others have reported evasive
replies from On Software.  I do not know whether anyone has contacted
Gemtek.

The upshot is that it appears that Dell is not in GPL compliance, but it
may not be entirely their fault.  It is, however, Dell's responsibility at
this point to obtain and release the correct source since they sell the
product that contains the binaries.  I imagine that this whole thing has
caught Dell off-guard, and the folks I've spoken to at Dell all appear to
be working toward finding a good solution.

I would like to continue to provide Dell with good, positive
encouragement.  I am posting this message to find out whether there is
anyone else following up on this, and to let people know the current
status from my perspective.  I've purchased one of these Dell boxes and
I'd love to reflash it with my own build (I'd really like to get a working
network bootloader in there).

Thoughts?  Guidance?
Let me know.

Thanks.

Chris -)-----

--
"Implementing CIFS - the Common Internet FileSystem" ISBN: 013047116X
Samba Team -- http://www.samba.org/     -)-----   Christopher R. Hertel
jCIFS Team -- http://jcifs.samba.org/   -)-----   ubiqx development, uninq.
ubiqx Team -- http://www.ubiqx.org/     -)-----   crh@ubiqx.mn.org
OnLineBook -- http://ubiqx.org/cifs/    -)-----   crh@ubiqx.org

