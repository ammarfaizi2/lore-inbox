Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVANPgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVANPgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVANPgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:36:05 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:8077 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S262011AbVANPfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:35:54 -0500
Message-ID: <41E7E6D7.10303@q-leap.com>
Date: Fri, 14 Jan 2005 16:35:51 +0100
From: Peter Kruse <pk@q-leap.com>
Organization: Q-Leap Networks GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Peter Kruse <pk@q-leap.com>
Subject: Random packets loss under x86_64 - routing?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.4.28 smp x86_64

Hello,

We experience a problem in our amd64 beowulf clusters and could need
some help.
When ping'ing other machines in a cluster on the same
subnet, it fails for some machines.  But only right after boot
and after a day or so of idle time.  After some time (a few minutes) the
ping packets go through.

Other things we observed:

1. it is not always the same machines that fail
2. if it fails then no packets are sent or received (checked with
    tcpdump on sending and target host) although all hosts are up.
3. There is no difference if using a 64bit or 32bit ping
4. It does not depend on the network adapter or other hardware, we have
    machines with different NICs connected to different switches with the
    same problem.
5. It does however only happen on amd64 (biarch) systems and not on
    pure i386 systems so it looks like related to the kernel.
6. I have to reboot to reproduce the problem, it's not enough to
    unload and load the network module.
7. It only happens with ping, not with ssh.

The ping always succeeds when running with the "-r" switch,
that bypasses "the normal routing tables and send directly to a host
on an attached interface".  This makes us think that it indeed it is
related to routing - but how?

I can provide an strace output if you think that could help.
What else can I do to gather more information?

Please cc to me, as I'm not subscribed, thanks.

	Peter

-- 
Peter Kruse <pk@q-leap.com>, Chief Software Architect
Q-Leap Networks GmbH
phone: +497071-703171, mobile: +49172-6340044


