Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbWAGVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbWAGVlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWAGVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:41:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45452 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030594AbWAGVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:41:46 -0500
Subject: Re: 2.6.15-mm2
From: Arjan van de Ven <arjan@infradead.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43C03214.5080201@ens-lyon.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com>
	 <43C03214.5080201@ens-lyon.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 22:41:40 +0100
Message-Id: <1136670100.2936.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Assuming this is a PCI Express card, then what is the proper fix ?
> Should I prevent my initscript from loading agpgart (actually intel_agp)
> at all ? (I guess udev or hotplug is trying to load it here). Is there
> something like agpgart for PCI express ? Or is it useless ?

PCI express neither needs nor can use AGP.

(and to be honest, AGP is one of those things that is best compiled into
the kernel if you need it. AGP deals with system/memory resources, and
some bioses fuck that up. If agp is built in, it'll be fixed in time.
There have been a series of bugs about it against fedora, until it we
made it compiled in .. and poof.. bugs gone)


