Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTIZGQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTIZGQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:16:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:7619 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261956AbTIZGQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:16:45 -0400
Message-ID: <3F73D9C4.1050201@colorfullife.com>
Date: Fri, 26 Sep 2003 08:16:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:

>Fine, then we should have something like an rx_copybreak scheme in
>the ns83820 driver too.
>  
>
Is that really the right solution? Add a full-packet copy to every driver?
IMHO the fastest solution would be to copy only the ip & tcp headers, 
and keep the rest as it is. And preferable in the network core, to avoid 
having to copy&paste that into every driver.

--
    Manfred

