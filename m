Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTACA4y>; Thu, 2 Jan 2003 19:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTACA4y>; Thu, 2 Jan 2003 19:56:54 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:61391 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267387AbTACA4w>; Thu, 2 Jan 2003 19:56:52 -0500
Message-Id: <5.1.0.14.2.20030102165932.073a2f10@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 02 Jan 2003 17:05:10 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: [BK] Bluetooth fixes for 2.4.21-pre2
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Happy New Year.

Here are some more Bluetooth fixes.

Please pull from 
        bk://linux-bt.bkbits.net/bt-2.4

This will update the following files:

 arch/sparc64/kernel/ioctl32.c |   37 +++++++++++++++++++++++++++++--------
 net/bluetooth/bnep/bnep.h     |   30 +++++++++++++++---------------
 net/bluetooth/bnep/core.c     |   12 ++++++------
 net/bluetooth/bnep/sock.c     |   20 ++++++++++----------
 net/bluetooth/rfcomm/core.c   |   25 +++++++++++++------------
 net/bluetooth/rfcomm/sock.c   |    6 +++---
 6 files changed, 76 insertions(+), 54 deletions(-)

through these ChangeSets:

<maxk@qualcomm.com> (02/12/16 1.803.1.4)
   Move Bluetooth ioctls after USB and other stuff in sparc64/kernel/ioctl32.c.

<maxk@qualcomm.com> (02/12/16 1.803.1.3)
   Remove old BNEP ioctls. These are internal. Only one app is supposed
   to use them, so there is no compatibility problem.
<marcel@holtmann.org> (02/12/14 1.803.1.2)
   [Bluetooth] Add some COMPATIBLE_IOCTL for SPARC64
   
   This patch adds the needed COMPATIBLE_IOCTL for SPARC64 to let
   the HCIUART, RFCOMM and BNEP part of the Bluetooth subsystem
   work correctly on this architecture.

<marcel@holtmann.org> (02/12/11 1.803.1.1)
   [Bluetooth] Convert dlci and channel variables to u8
   
   This patch converts all left over dlci and channel variables of
   the RFCOMM code from int to u8.



Max

http://bluez.sf.net
http://vtun.sf.net

