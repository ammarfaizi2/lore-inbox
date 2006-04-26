Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWDZPaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWDZPaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDZPaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:30:05 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:38385 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932479AbWDZPaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:30:02 -0400
Message-ID: <444F91F8.80809@zonnet.nl>
Date: Wed, 26 Apr 2006 17:30:00 +0200
From: "David G." <kiddion@zonnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729 MultiZilla/1.7.9.0a
X-Accept-Language: nl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: realoneone@gmail.com
Subject: Re: How to re-send out the packets captured by my hook function at
 NF_IP_PRE_ROUTING
References: <65RDw-7AC-33@gated-at.bofh.it>
In-Reply-To: <65RDw-7AC-33@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 15:32:11.0968 (UTC) FILETIME=[96778400:01C66946]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Real Oneone wrote:
> Hi, I plugged a callback function into netfilter at the hook point of
> NF_IP_PRE_ROUTING, tring to capture all the packets, make
> some changes to some of them, and invoke skb->dev->hard_start_xmit to
> send them out directly. However, the kernel crashed before I could get
> any printked information.
> 
> If you have any idea of how to send the received packets out, please tell me.

You might want to explore the possibilities of the existing "ip_queue"
kernel extension instead, it was design to do packet
capture/inspection/changing in userspace.

FireFlier works that way ( http://fireflier.sourceforge.net/ ) and so
does inlined snort (http://www.snort.org/docs/snort_manual/node7.html).

You can take a look at:
http://www.linuxia.de/netfilter.en.html#userspace and
http://www.cs.princeton.edu/~nakao/libipq.htm for an example application.
