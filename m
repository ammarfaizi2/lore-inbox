Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUIFHup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUIFHup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUIFHup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:50:45 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:63621 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267578AbUIFHui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:50:38 -0400
Message-ID: <413C16CE.30607@de.ibm.com>
Date: Mon, 06 Sep 2004 09:50:38 +0200
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
References: <200409011441.10154.elueck@de.ibm.com> <200409021858.38338.elueck@de.ibm.com> <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org> <200409031007.29467.elueck@de.ibm.com> <Pine.LNX.4.61.0409031747580.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409031747580.23011@fogarty.jakma.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:

> You could try:
>
> ip route change default via <gateway> src <vipa>
>
> Presuming the NFS clients are behind a gateway. If also onlink, you 
> need to modify the connected routes and change the src there too.
>
We have tried it this way, of course, and it works. But the 
corresponding routes are static. In our context, all routes have to be 
dynamic (for fault tolerance and due to configuration overhead). Zebra 
and OSPFD do not support this type of route. As a consequence, this 
approach does not work for us. Anyway, iptables is the way to do it.

Regards,

Einar.

