Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUCAWU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUCAWU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:20:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:12993 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261459AbUCAWTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:19:42 -0500
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Michael Frank <mhf@linuxmail.org>, Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040301115708.GB2774@hell.org.pl>
References: <1ulUA-33w-3@gated-at.bofh.it>
	 <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	 <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>
	 <20040229213302.GA23719@luna.mooo.com>
	 <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
	 <20040301113528.GA21778@hell.org.pl> <1078140689.21577.78.camel@gaston>
	 <20040301115708.GB2774@hell.org.pl>
Content-Type: text/plain
Message-Id: <1078178921.21575.131.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 09:08:42 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, the AGP problem is black magic to me. Those hangs / reboots happen
> during the copying of the original kernel back (when S4 is concerned) and
> that's completely beyond me, sorry.

Where, the whole swsusp thing is very fragile by design... I'd say you
probably need to disable the AGP bridge & release all AGP memory when
doing that copying, and re-enable it on wakeup. The list of pages used
for AGP have changed between both of those...

> I did try to look into the USB problem back then, but again, I couldn't
> find anything significantly different between 2.4 and 2.6, so I backed out.
> Anyway, you're still right about that one should fix it instead of
> complaining...
> Best regards,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

