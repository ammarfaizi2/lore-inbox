Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUIFH6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUIFH6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIFH6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:58:00 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:38289 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267585AbUIFH5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:57:50 -0400
Date: Mon, 6 Sep 2004 08:57:42 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: lkml@einar-lueck.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
In-Reply-To: <413C16CE.30607@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409060854100.23011@fogarty.jakma.org>
References: <200409011441.10154.elueck@de.ibm.com> <200409021858.38338.elueck@de.ibm.com>
 <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org> <200409031007.29467.elueck@de.ibm.com>
 <Pine.LNX.4.61.0409031747580.23011@fogarty.jakma.org> <413C16CE.30607@de.ibm.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Einar Lueck wrote:

> We have tried it this way, of course, and it works. But the 
> corresponding routes are static. In our context, all routes have to 
> be dynamic (for fault tolerance and due to configuration overhead).

then change the 'connected' routes. that's all you need to affect 
source address selection. All your other dynamic routes will still 
work.

> Zebra and OSPFD do not support this type of route.

ospfd never would. You could add the required support to zebra if you 
wished. ;)

> As a consequence, this approach does not work for us. Anyway, 
> iptables is the way to do it.

One way, but quite a kludge to effectively NAT local machines. You'd 
be much better up configuring the routes which affect source address 
selection to taste.

anyway..

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
All of the animals except man know that the principal business of life is
to enjoy it.
