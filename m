Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTFPWPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTFPWPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:15:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:1014 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264447AbTFPWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:15:46 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: Daniel Stekloff <stekloff@us.ibm.com>, janiceg@us.ibm.com,
       jgarzik@pobox.com, kenistonj@us.ibm.com,
       Larry Kessler <lkessler@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com, <niv@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF1F6B3DC.30C0E5DE-ON85256D47.007AEFAF@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Mon, 16 Jun 2003 17:29:15 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/16/2003 18:29:19
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "David S. Miller" <davem@redhat.com>
   Date : 06/16/2003 05:13 PM

   egrep "promiscuous mode" net/core/dev.c | grep printk

I noticed when I performed the grep, the printk shows:
      printk(KERN_INFO "device %s %s promiscuous mode\n"

For the sake of consistency and automatic error log analysis, it might be
nice to standardize on a message closer to:
      printk(KERN_INFO "%s: %s promiscuous mode\n"

It's somewhat common, but not universal to start the error message with the
device name followed by a colon.

Janice



