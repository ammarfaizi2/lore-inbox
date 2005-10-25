Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVJYUfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVJYUfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVJYUfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:35:18 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:48912 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932357AbVJYUfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=FdRZhxR8UZmtFwqhfqo7r/kts12tV6h7NTdgy4Fz2o144tNd0yxCOf9gxmFc7v7sqCYqDdQ7Zab3mPMuI/GO+jFTmyHt+bAzIOUemYKuH2IJlgjasHgsIBRLVVZ1ufJ9vFWrS8i946btsV7wiQ/1lF1kwDvo5v8Tbh1WAdsDLLE=
Message-ID: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
Date: Tue, 25 Oct 2005 22:35:15 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7608_6198175.1130272515592"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7608_6198175.1130272515592
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Happened to me the third time now in the last
 couple of months, always with different Linus
 kernels (plus ACX100 wireless module from
 Denis Vlasenko's snapshots) all hanging off
 an up-to-date FC4, all built with latest stock
 GCC; this last is:

[root@incident ~]# cat /proc/version
Linux version 2.6.14-rc5-git5 (asuardi@incident) (gcc version 4.0.2)
#1 PREEMPT Tue Oct 25 14:32:46 CEST 2005

Symptoms: startx at the command prompt gets
 the blank screen, then... nothing. Keyboard is
 dead (CapsLock doesn't get its led lit), no VT
 switching works. Box is still reachable via ssh
 through its wireless network card, all looks OK
 except for X running and piling up CPU time,
 and apparently untraceable (pstack, strace
 hang trying to attach it) and unkillable (kill -9
 doesn't kill it).

I took a couple of SysRQ 't' dumps via the
 /proc/sysrq-trigger facility and the outcome is
 attached - actually it's a full messages log,
 startup to reboot.

Exact sequence this time:
 1. boot
 2. insmod 0.3.17 acx driver
 -> notice I can't contact my wireless AP
 3. rmmod it, insmod 0.3.16 driver
 -> notice I am an idiot, plug in the wireless AP power cord
 4. rmmod 0.3.16, insmod 0.3.17, iwconfig wlan0 up
 5. switch to VT2 (Alt-F2), login as non-root, run startx
<blank screen, dead keyboard>
 6. ssh in from remote box, take SysRQ dumps, reboot

If anyone has an idea on what to do to try and reproduce
 and/or debug further, that'd be cool.

Box is a Dell Latitude C640 laptop, PIV@1.8Ghz,
 1GB RAM, with a USR2210 802.11b wireless
 PC Card; video card is a Radeon 7500 M7 LW.

Thanks in advance, ciao,

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")

------=_Part_7608_6198175.1130272515592
Content-Type: application/x-bzip2; name=messages.bz2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="messages.bz2"









------=_Part_7608_6198175.1130272515592--
