Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVFPT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVFPT1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVFPT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:27:15 -0400
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:46744 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261799AbVFPT1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:27:13 -0400
Message-Id: <44039q$12aja01@mxip15a.cluster1.charter.net>
X-IronPort-AV: i="3.93,204,1115006400"; 
   d="scan'208"; a="1151969281:sNHT14641016"
X-Mailer: Openwave WebEngine, version 2.8.18 (webedge20-101-1108-20050216)
From: <mhlong@charter.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 PNP issues with software raid system
Date: Thu, 16 Jun 2005 15:27:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a disk is pulled or fails in such a way that the hotplug manager removes the corresponding /dev/xxx entry, I can not issue a mdadm --remove because the device doesn't exist.

I looked at the mdadm and md code and it looks like it relies on the device node existing.  I could make the appropriate code changes but wanted to see if there was another more standard way to deal with this.  I know I can create a node using mknod so I can issue the mdadm --remove and then delete the node but this really seems like a hack.

I did a bit of looking around and couldn't find an answer to this.  If this is not the right list for this question please point me to the correct place.

Thanks, -Matt-

