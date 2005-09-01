Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVIALcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVIALcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVIALcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:32:09 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:52205 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932387AbVIALcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:32:08 -0400
Date: Thu, 1 Sep 2005 13:36:14 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB Storage speed regression since 2.6.12
Message-ID: <20050901113614.GA63@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I don't know if this is a known issue, but usb-storage speed for
'Full speed' devices dropped from 2.6.11.12 (more than 800Kb/s) to
2.6.12 (less than 250Kb/s). The problem still exists in 2.6.13.

    The lack of speed seems to affect only the OHCI driver. My test
was done over a PCI USB 2.0 card, ALi chipset, OHCI driver (well
EHCI+OHCI) and using a full speed device capable of 12MBps. The
average measured speeds are:

    - 2.4.31:           about 450Kb/seg
    - 2.6.11-Debian:    about 800Kb/seg
    - 2.6.11.12:        about 820Kb/seg
    - 2.6.12.x:         about 200Kb/seg
    - 2.6.13:           about 200Kb/seg

    The .config is more or less the same in all kernels. I've took a
look at the ChangeLog for 2.6.12 and there are lots of changes in the
USB subsystem but I cannot identify which one could be the culprit.

    If anyone needs more information (for example, device
identification in all kernels) just tell. I don't provide much more
information since this can be a known issue and so there is no need
to pollute the list with a long .config and dmesg output...

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
