Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268502AbTCAFLb>; Sat, 1 Mar 2003 00:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268504AbTCAFLb>; Sat, 1 Mar 2003 00:11:31 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37039 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S268502AbTCAFLa>; Sat, 1 Mar 2003 00:11:30 -0500
Message-ID: <3E60578E.4050608@hotmail.com>
Date: Fri, 28 Feb 2003 22:47:42 -0800
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre4-ac7]  Um, is this a kernel oops?  Or not.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I see this only with ac7, not with ac6 or earlier:

# swapon -s
Filename                        Type            Size    Used    Priority
/dev/ide/host0/bus0/target1/lun0/part3 partition        136544  0       -3

# swapoff -va
swapoff on /dev/ide/host0/bus0/target1/lun0/part3
swapoff on /dev/hdb3
Unable to handle kernel NULL pointer dereference at virtual address 00000015
  printing eip:
  c01454ce
  pde*=00000000
  oops:002
  <lots of hex numbers snipped>
Segmentation fault </sbin/swapoff is the process that segfaults>

At this point after an oops I expect to see a system crash/reboot but it this
case the system continues on as if nothing had gone wrong, so I'm confused
about what is happening here.  If the rest of the oops message would be
useful I will transcribe and post it for you.

The swapspace is actually deactivated, BTW, before swapoff crashes, and I
can turn it back on with swapon as if nothing had happened.

