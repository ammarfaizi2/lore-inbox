Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBOKm0>; Thu, 15 Feb 2001 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbRBOKmR>; Thu, 15 Feb 2001 05:42:17 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:64688 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S129396AbRBOKmH>;
	Thu, 15 Feb 2001 05:42:07 -0500
Message-ID: <3A8BB28B.B2A51C57@debian.org>
Date: Thu, 15 Feb 2001 11:42:19 +0100
From: Giacomo Catenazzi <cate@debian.org>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en, en-US, en-GB
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNONCE] Kernel Autoconfiguration utility v.0.9.1.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2001 10:42:05.0791 (UTC) FILETIME=[F05DAEF0:01C0973B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I just release a new verion of kernel autoconfig.
The kernel autoconfiguration utility will help user to detect and
configure the kernel. The detection is soft, thus no hangs!

It is still in test phase, thus now it prints only the proposed
configuration. To change real configurations, I'm still waiting for
a working CML2.


On my hardware database there are:

1007  pci cards
 111  devices (block and char)
  37  file systems
   7  console drivers
   8  net protocols
 511  resources strings.

+ some extra special detection.

Project homepage:
 http://sourceforge.net/projects/kautoconfigure/

How to use: (now, testing phase)
  unpack the files (better: in a new directory)
  > bash autoconfigure.sh | less
  check the output.
  no super user privileges required!


I need some help:
- Some drivers detect pci in a strange way, I could not check every
files.
  Please check if your cards are included.
- Check, add extra detections


I will do:
- updates to the database when a new official kernel version is released
- interface with CML2 (partially done, but CML2-9.0.1 has still bugs)
- better 'CONFIG_*=N' handling (e.g. I will check is a drivers depends
  on PCI. If this PCI card is not found, I can safely tell you that the
  device is not in the box).
- generate inverse dependences.


Comments?


        giacomo


PS. I have done the autodetection reading the source and not using
    real hardware, thus ... no warranty.

PPS: This tools is designed mainly for newbies (in kernel compiling...),
     thus I don't expect to have a real autodetection on very special
     machines. [But I expect in the future to do this :-) ]
