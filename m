Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWG1TmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWG1TmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWG1TmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:42:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64907 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030286AbWG1TmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:42:23 -0400
Subject: Re: [PATCH] amd74xx: implement suspend-to-ram
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Lunz <lunz@falooley.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060728171357.GB17549@knob.reflex>
References: <200607281646.31207.rjw@sisk.pl>
	 <1154105517.13509.153.camel@localhost.localdomain>
	 <20060728171357.GB17549@knob.reflex>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 21:00:26 +0100
Message-Id: <1154116826.13509.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-28 am 13:13 -0400, ysgrifennodd Jason Lunz:
> OK, I'll see about moving it there. Will this still be
> controller-specific, or are you suggesting this is something ide ought
> to do globally?

It should be done globally. In many cases the chips start up from power
on configured for PIO 0 so that side happens to work, but not all chips
do this as you've found out. Setting the PIO side correctly is a fix
even if its not a bug people hit a lot.

Alan

