Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWGEQM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWGEQM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWGEQM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:12:56 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:12849 "HELO
	toe-A.terreactive.ch") by vger.kernel.org with SMTP id S964804AbWGEQMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:12:55 -0400
Message-ID: <44ABE4FF.1000006@drugphish.ch>
Date: Wed, 05 Jul 2006 18:12:47 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.17.1 in vfs_statfs (maybe oprofile related)
References: <44ABDE30.6080307@drugphish.ch> <1152114494.3201.41.camel@laptopd505.fenrus.org>
In-Reply-To: <1152114494.3201.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Jul  5 16:38:11 BUG: unable to handle kernel paging request at virtual
>> address f89d4888
>> Jul  5 16:38:11 printing eip:
>> Jul  5 16:38:11 c10510e0
>> Jul  5 16:38:11 *pde = 00000000
>> Jul  5 16:38:11 Oops: 0000 [#1]
>> Jul  5 16:38:11 SMP
>> Jul  5 16:38:11 Modules linked in: raid1 e1000 ipmi_si ipmi_devintf
>> ipmi_msghandler ext3 jbd md_mod
>> Jul  5 16:38:11 CPU:    0
>> Jul  5 16:38:11 EIP:    0060:[<c10510e0>]    Tainted: G  R   VLI
> 
> you did an rmmod -f ...
> is does this happen if you don't do that as well ?

Every now and then, however I cannot capture the oops right now. It
looks completely different. One I got after this session 5 minutes ago:

node:~# mount
/dev/sda1 on / type ext3 (rw)
/dev/sda3 on /var type ext3 (rw)
/dev/sda4 on /usr type ext3 (rw)
nodev on /dev/oprofile type oprofilefs (rw)
sysfs on /sys type sysfs (rw)
loghost:~# lsmod
Module                  Size  Used by
oprofile               26432  1
e1000                  98360  0
ipmi_si                31056  1
ipmi_devintf            6792  2
ipmi_msghandler        28480  2 ipmi_si,ipmi_devintf
iptable_nat             6660  0
ip_nat                 13484  1 iptable_nat
iptable_mangle          2560  0
ext3                  101896  2
jbd                    53664  1 ext3
md_mod                 59156  0
node:~# umount /dev/oprofile/
Segmentation fault

Thanks for your feedback. I will get to lkml as soon as I have something
people can actually reproduce, not involving rmmod -f, and which I can
capture. No need to further look into it.

Best regards,
Roberto Nibali, ratz
-- 
-------------------------------------------------------------
addr://Kasinostrasse 30, CH-5001 Aarau tel://++41 62 823 9355
http://www.terreactive.com             fax://++41 62 823 9356
-------------------------------------------------------------
10 Jahre Kompetenz in IT-Sicherheit.              1996 - 2006
Wir sichern Ihren Erfolg.                      terreActive AG
-------------------------------------------------------------
