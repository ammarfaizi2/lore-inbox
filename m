Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWE0MEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWE0MEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWE0MEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:04:48 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:38877 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750775AbWE0MEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:04:47 -0400
Message-ID: <4478409D.3030706@free.fr>
Date: Sat, 27 May 2006 14:05:49 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke userspace
 apps
References: <4454B4A1.4060304@free.fr> <447212C1.403@gmail.com>
In-Reply-To: <447212C1.403@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Le 22.05.2006 21:36, Jim Cromie a écrit :
> Laurent Riffard wrote:
>> Hello,
>>
>> Since 2.6.17-rc1-mm3, some applications behave strangely here:
>> - video players (mplayer, vlc) are randomly frozen after less than 1
>> minute playing . They are killable by ^C.
>> - some network java application (freenet-0.7) quit after a few
>> minutes running.
>>
>> A bissection point out time-i386-clocksource-drivers.patch as the
>> sucker.
>>
>> I noticed that, since 2.6.17-rc1-mm3, pit clocksource is installed
>> instead of acpi_pm clocksource. Booting with "clocksource=acpi_pm"
>> does not help.
> 
>> Is pit clocksource broken ? If so, how can I get back acpi_pm
>> clocksource ?
>>
>>   
> Followup on the 1st Q:
> GTS v.C2 had some pit fixes, what happens now testing with
> clocksource=pit ?
> 

Sorry for this late answer.

Now, I can't notice any problem with clocksource=pit. Video players and
freenet-0.7 are running fine.

> [root@antares ~]# dmesg | grep -e clocksource -e "Linux version"
> Linux version 2.6.17-rc4-mm3 (laurent@antares.localdomain) (gcc version 4.1.1 20060330 (prerelease)) #10 Tue May 23 01:35:36 CEST 2006
> Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb6 clocksource=pit
> Time: pit clocksource has been installed.

Thanks.
- --
laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEeECdUqUFrirTu6IRAvedAKCPmsiaQYUuxhiOPblsyGCHUg4BYwCgjIkA
NY1utbG3qXCNJKk3mV25zVo=
=zJjX
-----END PGP SIGNATURE-----
