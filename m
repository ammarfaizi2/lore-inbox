Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbQKCAjh>; Thu, 2 Nov 2000 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130122AbQKCAj1>; Thu, 2 Nov 2000 19:39:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38149 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130013AbQKCAjM>;
	Thu, 2 Nov 2000 19:39:12 -0500
Message-ID: <3A020920.4559F400@mandrakesoft.com>
Date: Thu, 02 Nov 2000 19:38:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0.10: Update hotplug
In-Reply-To: <007401c04527$dc094510$6500000a@brownell.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
>     - Changing /sbin/hotplug invocations ... now it can
>       only support "add" and "del" events.  (USB now
>       uses "add" and "remove", though "remove" doesn't
>       try to do anything yet.)
> 
>       This removes the intended flexibility whereby
>       different subsystems (such as networking) can
>       define their own events.

Wrong.  Different subsystems -do- define their own events.  However,
different subsystems should use the same verbs for the same actions.  We
need consistency where possible.


>     - "/sbin/hotplug net ..." replaced by "/sbin/network",
>       with two custom event types.

Hotplug device insertion and network interface addition/removal are two
fundamentally different things.  Further, my code purposefully does not
wrap CONFIG_HOTPLUG around the /sbin/network code, because /sbin/network
has utility outside the domain of hotplug.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
