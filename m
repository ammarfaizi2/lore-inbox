Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWIGX4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWIGX4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWIGX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:56:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26006 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751915AbWIGX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:56:42 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:55:24 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 0/2] ieee1394: ohci1394: endianess bug in verbose debug log
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Wolfgang Pfeiffer <roto@gmx.net>, Ben Collins <bcollins@ubuntu.com>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a debug macro on some big endian machines.  Related code is
touched up too to make it harder to introduce such bugs in the future.

 - ieee1394: ohci1394: fix endianess bug in debug message
 - ieee1394: ohci1394: more obvious endianess handling

Wolfgang, could you test and send an ACK?  The tlabel in each "Packet
received from node" message should match that of the previous "Packet
sent to node" line.  Example of a wrong log:
http://www.wolfgangpfeiffer.com/disable-irm.kern.log.when.fw.disk.is.switched.on.txt
The received tlabel was always 48 on this Apple AluBook 5,8.
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/

