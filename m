Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRCLBAO>; Sun, 11 Mar 2001 20:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129318AbRCLBAE>; Sun, 11 Mar 2001 20:00:04 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:56269 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S129270AbRCLA7o>; Sun, 11 Mar 2001 19:59:44 -0500
Date: Mon, 12 Mar 2001 01:48:11 +0100
To: linux-kernel@vger.kernel.org
Subject: hotplug and interrupt context
Message-ID: <20010312014811.B472@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't trace that down to be 100% sure and it's better to conform to
design than implementation, so I'll ask:

Do the probe and remove functions of a pci_driver have to be able to
work in interrupt context?  (i.e. GFP_ATOMIC and stuff)


I expect so, since CardBus handling doesn't start a thread and would
call these functions from the context it got the insertion message
(interrupt context).

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
