Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUE1WuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUE1WuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUE1Wrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:47:55 -0400
Received: from tmailb1.svr.pol.co.uk ([195.92.168.141]:28944 "EHLO
	tmailb1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S264076AbUE1Wkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:40:39 -0400
Subject: XP to linux over SK98 gigabit, 150KB/sec ?
From: Eamonn Hamilton <bethaud99@hotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085784184.15385.9.camel@snifter.freeserve.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 May 2004 23:43:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I'm looking at a very weird problem here, and I was hoping somebody had
seen this before.

A friend has a network, two XP systems and two linux boxes on a gigabit
switch all with Marvell Yukon-based cards in. XP->XP, he gets ~20MB/sec
,linux to linux is the same kind of rate using the sk98lin driver under
2.6.6. Jumbo frames are out as the switch doesn't support them.

Bizarrely, however, he gets 20MB/sec reads from linux to XP, but
150KB/sec writes using either ftp or samba, unless he streams from the
linux box using anything else on the network, in which case the
bandwidth goes up, but not  to the consistent 20MB/sec. This almost
working state of affairs was arrived at after disabling PMTU discovery
on the XP systems, but all the systems use the same MTU which is 1500
bytes.

I've upped the rmem_max and wmem_max to 256kb each, but this doesn't
seem to have helped. 

Has anybody seen this kind of behaviour, or got any ideas?

Cheers,
Eamonn
 
 
--
"He's an immortal small-town boxer with a passion for fast cars. She's
an artistic snooty vampire with an MBA from Harvard. They fight crime!"

