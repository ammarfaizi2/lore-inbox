Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUAKMNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUAKMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:13:44 -0500
Received: from mx02.qsc.de ([213.148.130.14]:1416 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265853AbUAKMMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:12:45 -0500
Message-ID: <40013CBF.1080707@trash.net>
Date: Sun, 11 Jan 2004 13:08:31 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: Wilmer van der Gaast <lintux@lintux.cx>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net> <20040110215954.GC20706@sunbeam.de.gnumonks.org> <40012825.60405@trash.net>
In-Reply-To: <40012825.60405@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

> BTW: Why do we need a route lookup at all ? Couldn't we just use the 
> first address on dev->in_dev->ifa_list ?
>

I've attached two patches (2.4+2.6) to the bugtracker which change
MASQUERADE to use indev->ifa_list->ifa_local. The 2.6 version is
running here without problems so far. Please have a look at
https://bugzilla.netfilter.org/cgi-bin/bugzilla/show_bug.cgi?id=144 .

Best regards,
Patrick

