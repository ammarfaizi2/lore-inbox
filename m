Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQL2TTJ>; Fri, 29 Dec 2000 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132031AbQL2TS7>; Fri, 29 Dec 2000 14:18:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38151 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130061AbQL2TSp>; Fri, 29 Dec 2000 14:18:45 -0500
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 29 Dec 2000 18:50:18 +0000 (GMT)
Cc: ppetru@ppetru.net (Petru Paler), pegasus@telemach.net (Jure Pecar),
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
In-Reply-To: <20001229165340.C12791@athlon.random> from "Andrea Arcangeli" at Dec 29, 2000 04:53:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14C4bd-0005bM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 29, 2000 at 09:38:40AM +0200, Petru Paler wrote:
> > This is one of the main thttpd design points: run in a select() loop. Since
> > it is intended for mainly static workloads, it performs quite well...
> 
> It can't scale in SMP.

Your cgi will keep the other CPU occupied, or run two of them. thttpd has
superb scaling properties compared to say apache.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
