Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271996AbTGYJoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 05:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271997AbTGYJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 05:44:12 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:21262 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S271996AbTGYJoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 05:44:10 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1, usbfs: devgid parameter seems ignored
Mail-Copies-To: nobody
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Fri, 25 Jul 2003 12:02:48 +0200
Message-ID: <plopm3ptjy3ovr.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've tried Linux 2.6.0-test1, -ac1 and -ac3 on two computers, and each
time the options passed (like devgid or devmode) to usbfs when mouting
it seem to be ignored:

(kilobug@drizzt, 8) ~ $ sudo mount none -t usbfs /proc/bus/usb -o devgid=143,devbmode=0664
(kilobug@drizzt, 9) ~ $ ls /proc/bus/usb
001  002  devices
(kilobug@drizzt, 10) ~ $ ls -l /proc/bus/usb
total 0
dr-xr-xr-x    2 root     root            0 Jul 25 09:34 001
dr-xr-xr-x    2 root     root            0 Jul 25 09:34 002
-r--r--r--    1 root     root            0 Jul 25 09:34 devices
(kilobug@drizzt, 11) ~ $ ls -l /proc/bus/usb/001/
total 0
-rw-r--r--    1 root     root           43 Jul 25 09:34 001

With exactly the same entry in fstab:
/proc/bus/usb   /proc/bus/usb   usbdevfs rw,devmode=0664,devgid=143     0 0
it works fine with 2.4.

It's pretty annoying to be forced  to use sudo just to download photos
from my camera ! ;)

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
