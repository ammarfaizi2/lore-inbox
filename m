Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbTK0SuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264580AbTK0SuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:50:22 -0500
Received: from main.gmane.org ([80.91.224.249]:417 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264578AbTK0SuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:50:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
X-Quarantined-From: <news@complete.org>
X-Quarantined-To: <gmane-linux-kernel@moderator.gmane.org>
From: John Goerzen <jgoerzen@complete.org>
Subject: Promise IDE controller crashes 2.4.22
Date: Thu, 27 Nov 2003 18:43:20 +0000 (UTC)
Organization: Complete.Org
Message-ID: <slrnbsche8.2ir.jgoerzen@christoph.complete.org>
X-Complaints-To: usenet@complete.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Promise 20269-based UDMA 133 IDE controller.  If I have DMA
enabled on this controller, then when it is seeing heavy write activity,
the system freezes.  No messages on the console, ctrl-alt-del does
nothing, magic sysrq does nothing.

Reads do not appear to cause this problem, and the problem also
disappears if I disable DMA on the drive connected to the controller by
using hdparm.

System information:
Linux pi 2.4.22 #3 Sat Oct 25 15:45:50 CDT 2003 i586 GNU/Linux
AMD K6 400MHz processor

lspci:
00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20269
(rev 02)

Drive: Maxtor 6Y160P0 150GB UDMA 133

I have, in my .config:

CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_PDC202XX=y

Thanks for any insight.

-- John Goerzen


