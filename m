Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131782AbQKKAtN>; Fri, 10 Nov 2000 19:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131890AbQKKAtD>; Fri, 10 Nov 2000 19:49:03 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:64956 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131782AbQKKAsx>; Fri, 10 Nov 2000 19:48:53 -0500
Message-ID: <3A0C9778.E982F55B@uow.edu.au>
Date: Sat, 11 Nov 2000 11:48:56 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        netdev@oss.sgi.com
Subject: Re: PATCH: 8139too kernel thread
In-Reply-To: <200011102129.QAA13369@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> (note Linus, not for applying...)
> 
> Here is a patch, against 2.4.0-test11-pre2, that I wanted to forward
> to the lists for comment.
> 
> Many of the ethernet drivers have timer routines, which are
> called every three-five seconds or so.  These timer routines
> typically do stuff related to media selection or checking, and call
> mdio_{read,write} to interact with the phy.
> 

I think it's useful.  More generally, I'd like to have
"process context timers" - the ability to call a function
from process context at a set time.  Then a single kernel
thread could handle all things like this.  Pretty simple to do.


BTW: can the OOM killer possibly kill a kernel thread?
If it does, yenta_socket_thread() will nuke the machine.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
