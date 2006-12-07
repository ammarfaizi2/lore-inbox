Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032194AbWLGN2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032194AbWLGN2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032205AbWLGN2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:28:55 -0500
Received: from mail.permas.de ([195.143.204.226]:46349 "EHLO mail-gw.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1032194AbWLGN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:28:54 -0500
From: Hartmut Manz <manz@intes.de>
Reply-To: manz@intes.de
Organization: INTES GmbH
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2006 14:28:44 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071428.44850.manz@intes.de>
X-Anti-Virus: Kaspersky Mail Gateway, version 5.5.124/RELEASE, bases: 20061207 #248677, check: 20061207 clean
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: manz@intes.de
Subject: SCSI Controler SCRU32 becomes realy slow on the latest kernels
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on mail-gw.local)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using here 2 machines with the ICP Vortex SCSI-Controler SCRU32 for some 
years now.

After switching one machine from Debian 3.1 (sarge, with Kernel 2.6.8) to the 
upcoming Debian 4.0 (etch with Kernel 2.6.17 or 2.6.18) I have noticed that 
my scsi-devices become very slow while there is also a dramatical increase in
the sys time needed for I/O operations.

The machine is a dual processor Xeon system (2 * 2.2 GHz) with 2 GB memory.
The used scsi drives are seagate R10k and R15k disks.

i.e.  reading 1 GB from the first SCSI drive takes about:
xen-1:/var/log# time dd if=/dev/sda bs=256k count=4000 of=/dev/null
4000+0 records in
4000+0 records out
1048576000 bytes (1.0 GB) copied, 55.3079 seconds, 19.0 MB/s

real    0m55.361s
user    0m0.368s
sys     0m49.107s

There are two strange things: 
   1. The transfer rate is only 19 MB/sec what is very low for this machine.
       The expected value would be at least 50 MB/sec.

   2. the system time is in the same range as the real time and thats
       realy annoying,  on the old kernel the system time for such an operatin
       was about 7 sec.

Thanks for any help

Hartmut

-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
      Gott spricht: Ich lasse dich nicht fallen und verlasse dich nicht.
------------------------------------------------------  Josua 1, 5b ---------
