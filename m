Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbUK0BsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbUK0BsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbUK0BrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263011AbUKZTiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:20 -0500
Date: Thu, 25 Nov 2004 16:29:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problem
Message-ID: <20041125152922.GC12098@suse.de>
References: <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de> <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk> <20041122105157.GB10463@suse.de> <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk> <20041122113150.GF10463@suse.de> <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk> <20041122130202.GO10463@suse.de> <1101338347.2571.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101338347.2571.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Alan Cox wrote:
> > the following. It seems I was wrong in
> > assuming that the ide_intr() path already waited 400ns for us, I think
> > this should work for you. Can you test it?
> 
> The locking on ide_execute_command and friends is supposed to ensure
> this, can we please keep it out of the IRQ handler once its debugged ?

Something is funky with this drive, it requires an extra delay after it
has raised an interrupt. But we can restrict it to ide-cd once it's
fully understood.

-- 
Jens Axboe

