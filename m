Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbTC0XlM>; Thu, 27 Mar 2003 18:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTC0XlM>; Thu, 27 Mar 2003 18:41:12 -0500
Received: from dc-mx03.cluster1.charter.net ([209.225.8.13]:36578 "EHLO
	dc-mx03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S261595AbTC0XlJ>; Thu, 27 Mar 2003 18:41:09 -0500
Message-ID: <3E838956.1000400@charter.net>
Date: Thu, 27 Mar 2003 18:29:26 -0500
From: "B. Douglas Hilton" <bdhilton@charter.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.21-pre6 - "mbool" causes xconfig failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

"make xconfig fails" drivers/net/Config.in: 188: unknown command

[2.] Full description of the problem/report:

Lines 188 and 189 of drivers/net/Config.in reference a define_mbool and dep_mbool
which causes xconfig to fail. Switching these to define_bool and dep_bool allows
it to work.

[3.] Keywords (i.e., modules, networking, kernel):

mbool Config.in CONFIG_EEPRO100_PIO

[4.] Kernel version (from /proc/version):

2.4.21-pre6

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

n/a

[6.] A small shell script or example program which triggers the
      problem (if possible)

n/a

[7.] Environment

n/a

[7.1.] Software (add the output of the ver_linux script here)

n/a

[7.2.] Processor information (from /proc/cpuinfo):

n/a

[7.3.] Module information (from /proc/modules):

n/a

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

n/a

[7.5.] PCI information ('lspci -vvv' as root)

n/a

[7.6.] SCSI information (from /proc/scsi/scsi)

n/a

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

n/a

[X.] Other notes, patches, fixes, workarounds:

Just change "mbool" to "bool", not sure what the deal is here
or what an mbool is exactly.

