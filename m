Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbREaHNa>; Thu, 31 May 2001 03:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbREaHNV>; Thu, 31 May 2001 03:13:21 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:7812 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S262767AbREaHNI>; Thu, 31 May 2001 03:13:08 -0400
Message-ID: <3B15EF16.89B18D@idcomm.com>
Date: Thu, 31 May 2001 01:13:26 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac5-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: missing sysrq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled the magic sysrq as enabled in most kernels I've used for
quite a while. Most recently 2.4.5-ac5, on a RH 7.1 SMP machine with
APIC disabled. The /etc/sysctl.conf contains this line:
kernel.sysrq = 1

However, if I go to /proc/sys/kernel/sysrq does not exist. Nor is it
possible for root to echo to that file name. Attempts to use the magic
sysrq keys, such as for sync, prove that it truly is not enabled, or is
otherwise missing. Has something changed in the enabling of magic sysrq?
Or is this one of those strange "it should be there" things?

A second observation, maybe related (maybe not), is the
/var/log/messages line:
sysctl: error: permission denied on key 'vm.freepages'

This particular line has occurred since install of RH 7.1, even with its
original kernel, but continues into 2.4.5-ac5. The relevant line in
/etc/sysctl.conf:
vm.freepages = 383 766 1149

This line is how the original RH 7.1 install set it up. This particular
machine has 256 MB of ram, and somewhat over a 1 GB of swap. Is the
vm.freepages not intended to be set in /etc/sysctl.conf? Or maybe the
specs are off for this particular hardware? I know a lot of vm changes
are going on in the kernel, and wondering if this could be something
that used to be supported but no longer is.

D. Stimits, stimits@idcomm.com
