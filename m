Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTGMLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTGMLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:41:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50365
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270227AbTGMLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:41:20 -0400
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713115033.GA371@elf.ucw.cz>
References: <Pine.LNX.4.55.0307091929270.4625@bigblue.dev.mcafeelabs.com>
	 <20030713115033.GA371@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058097211.32496.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 12:53:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 12:50, Pavel Machek wrote:
> Hi!
> 
> > I finally found a couple of hours for this and I also found a machine were
> > I can run 2.5, since luck abandoned myself about this. The small page
> > describe the obvious and contain the trivial patch and the latecy test app :
> > 
> > http://www.xmailserver.org/linux-patches/softrr.html
> 
> What happens if evil user forks 60 processes, marks them all
> SCHED_SOFTRR, and tries to starve everyone else?

With the current scheduler you lose. Rik did some playing with a fair
share scheduler some time ago. That actually works very well for a lot
of these sorts of things. You can nice processes up (but only by
penalising your own processes) and conceptually you'd be able to soft
real time on a per user basis this way. 

Alan

