Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWGSPyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWGSPyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWGSPyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:54:02 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:24243 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030193AbWGSPyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:54:00 -0400
Message-ID: <44BE5589.4070403@cmu.edu>
Date: Wed, 19 Jul 2006 11:53:45 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607190005.02351.rjw@sisk.pl> <44BE4FB7.5050108@cmu.edu> <200607191742.32609.rjw@sisk.pl>
In-Reply-To: <200607191742.32609.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, well on my second try suspending to disk and resuming, i'm getting a
much different outcome... ls returns me resuls, however things are
slightly off:

x60s gnychis # ls
ls: downloads: Permission denied
ls: host_analysis: Permission denied
ls: SouthPark: Permission denied
ls: library: Permission denied
ls: cmu_dump: Permission denied
ls: emulator: Permission denied
ls: paper-KanKat.pdf: Permission denied
ls: quotes: Permission denied
ls: school: Permission denied
ls: cmu_dump2: Permission denied
host_graphs  host_level  key  mp3  odigw_k_pinw.wma  out-5M  pops  song
 test.save  thesis_rwork  todo
x60s gnychis # /etc/init.d/net.wlan0 restart
mkdir: cannot create directory `/var/lib/init.d/snapshot/9985':
Input/output error
cp: target `/var/lib/init.d/snapshot/9985/' is not a directory: No such
file or directory
 * Stopping wlan0
 *   Bringing down wlan0
/lib/rcscripts/net.modules.d/ifconfig: line 139: /usr/bin/tac: cannot
execute binary file
 *     Stopping dhcpcd on wlan0 ...
                                   [ ok ]
 *     Shutting down wlan0 ...
                                   [ ok ]
 * Starting wlan0
 *   Configuring wireless network for wlan0
 *     wlan0 connected to "SMC" at 00:04:E2:7D:D3:E3
 *     in managed mode (WEP enabled - open)
 *   Bringing up wlan0
 *     dhcp
 *       Running dhcpcd ...
                                   [ ok ]
 *       wlan0 received address 192.168.2.101
x60s gnychis # ping google.com
bash: ping: command not found

No clue :\

Thanks!
George


Rafael J. Wysocki wrote:
> On Wednesday 19 July 2006 17:28, George Nychis wrote:
>> Oh, and what should the default resume partition be (for
>> CONFIG_SOFTWARE_SUSPEND)? my root partition?
> 
> No, your swap partition, but you don't need to set it.
> 
> It can also be passed to the kernel with the resume= command line argument.
> 
> 
>> Rafael J. Wysocki wrote:
>>> On Tuesday 18 July 2006 17:26, George Nychis wrote:
>>>> acpid has been started, however there is no /sys/power/disk
>>> Have you set CONFIG_SOFTWARE_SUSPEND in .config?
>>>
>>> Rafael
>>>
> 
