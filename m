Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUK0Bvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUK0Bvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUK0BrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263013AbUKZTiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:20 -0500
Subject: Re: ide-cd problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122130202.GO10463@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk>
	 <200411211025.11629.alan@chandlerfamily.org.uk>
	 <200411211613.54713.alan@chandlerfamily.org.uk>
	 <200411220752.28264.alan@chandlerfamily.org.uk>
	 <20041122080122.GM26240@suse.de>
	 <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk>
	 <20041122105157.GB10463@suse.de>
	 <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk>
	 <20041122113150.GF10463@suse.de>
	 <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk>
	 <20041122130202.GO10463@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101338347.2571.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 23:19:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the following. It seems I was wrong in
> assuming that the ide_intr() path already waited 400ns for us, I think
> this should work for you. Can you test it?

The locking on ide_execute_command and friends is supposed to ensure
this, can we please keep it out of the IRQ handler once its debugged ?

