Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVA0XOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVA0XOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVA0XNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:13:39 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:62661 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261295AbVA0XMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:12:42 -0500
From: David Brownell <david-b@pacbell.net>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Date: Thu, 27 Jan 2005 15:11:57 -0800
User-Agent: KMail/1.7.1
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Art Haas <ahaas@airmail.net>
References: <200501232251.42394.david-b@pacbell.net> <priv$1106815487.koan@shadow.banki.hu> <200501271128.48411.david-b@pacbell.net>
In-Reply-To: <200501271128.48411.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501271511.58086.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got an interesting "I see these problems too" report.  It
may provide a useful clue.  According to "Art Haas" <ahaas@airmail.net>:

> I'm running the current BK kernel now, and I'm not seeing the problems
> right now because, I found, I do not have some of the IP masquerading
> modules installed on my machine. When these modules get installed then
> the cvs/rsync problems appear. 
 
I do have CONFIG_IP_NF_TARGET_MASQUERADE=y on the system where I'm
seeing this, though it's not doing anything just now.  Haven't yet
made time to see if disabling it improves things ... but if that's
a factor, it could explain why more people aren't suffering with
this problem.

- Dave
