Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbULQTlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbULQTlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbULQTfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:35:52 -0500
Received: from mail1.kontent.de ([81.88.34.36]:32437 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262148AbULQTaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:30:15 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [Coverity] Untrusted user data in kernel
Date: Fri, 17 Dec 2004 20:30:04 +0100
User-Agent: KMail/1.6.2
Cc: linux-os@analogic.com, Bill Davidsen <davidsen@tmr.com>,
       James Morris <jmorris@redhat.com>, Patrick McHardy <kaber@trash.net>,
       Bryan Fulton <bryan@coverity.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <41C26DD1.7070006@trash.net> <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com> <41C330F7.4000806@dbservice.com>
In-Reply-To: <41C330F7.4000806@dbservice.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412172030.04831.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But the difference between you example (cp /dev/zero /dev/mem) and 
> passing unchecked data to the kernel is... you _can_ check the data and 

This is the difference:
static int open_port(struct inode * inode, struct file * filp)
{
	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
}
(from mem.c)

	Regards
		Oliver
