Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUAZFtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUAZFtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:49:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265501AbUAZFtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:49:01 -0500
Message-ID: <4014AA49.8050800@redhat.com>
Date: Sun, 25 Jan 2004 19:48:57 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031225 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fedora-devel-list@redhat.com, linux-kernel@vger.kernel.org,
       fabrice@bellet.info
Subject: Trouble with Cisco Airo MPI350 and kernel-2.6.1+
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IBM Thinkpad T41
Cisco Airo MPI350 802.11b Wireless
PCIID: 0x14b9  0xa504
Kernel: Fedora rawhide 2.6.1-1.57 (Based on 2.6.2-rc1)

http://bellet.info/~bellet/laptop/t40.html#wireless
http://bellet.info/~bellet/laptop/airo.c-2.6.1-mm2.diff
airo.ko does not support this Airo device, but with the addition of this 
patch it recognizes the device.

airo: MAC enabled eth1 0:2:8a:df:50:fc
airo:  Finished probing for PCI adapters

[root@ibmlaptop root]# iwconfig
  	eth0      IEEE 802.11-DS  ESSID:"tsunami"
	Mode:Managed  Frequency:2.442GHz  Access Point: FF:FF:FF:FF:FF:FF
	Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
	Retry limit:16   RTS thr:off   Fragment thr:off
	Encryption key:off
	Power Management:off
	Link Quality:176/0  Signal level:-105 dBm  Noise level:-100 dBm
	Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
	Tx excessive retries:0  Invalid misc:416   Missed beacon:0
	<SNIP>

[root@ibmlaptop root]# iwconfig eth0 key 8208435e17
airo: Max tries exceeded waiting for command
PC4500_writerid: Write rid Error 65535
PC4500_writerid: Cmd=0121
airo:  WEP_PERM set ffff

[root@ibmlaptop root]# iwconfig
<SNIP>
eth0      IEEE 802.11-DS  ESSID:"tsunami"
	Mode:Managed  Frequency:2.442GHz  Access Point: FF:FF:FF:FF:FF:FF
	Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
	Retry limit:16   RTS thr:off   Fragment thr:off
	Encryption key:****-****-**   Security mode:open
	Power Management:off
	Link Quality:176/0  Signal level:-105 dBm  Noise level:-100 dBm
	Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
	Tx excessive retries:0  Invalid misc:488   Missed beacon:0

I am guessing that the *'s rather than hex characters displayed are 
because it is unable to read the key from the card.  The card itself 
appears to be completely inoperative.  It was suggested to me to try 
both "open" and "restricted" mode, both seem to not help the situation.

Any suggestions?

Warren Togami
wtogami@redhat.com
