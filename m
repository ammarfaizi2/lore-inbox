Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbTC0EMr>; Wed, 26 Mar 2003 23:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbTC0EMr>; Wed, 26 Mar 2003 23:12:47 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:2791 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S262834AbTC0EMq>; Wed, 26 Mar 2003 23:12:46 -0500
Message-ID: <3E827CDA.8030904@blue-labs.org>
Date: Wed, 26 Mar 2003 23:23:54 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030320
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.66 buglet
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-03-27 04:23:59, message serial number 842136
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<boot dmesg snip>
devfs_register(cpu/microcode): illegal mode: 8180
</snip>

# ls /dev/cpu
# grep -i microcode /boot/2.5.66/.config
CONFIG_MICROCODE=y

Not sure how it breaks between .64 where it worked and .66 where it 
doesn't.  The code where it's registered doesn't appear to have changed. 
arch/i386/kernel/microcode.c, line 137.

david


