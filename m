Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVIFXlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVIFXlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVIFXlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:41:03 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:63628 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751131AbVIFXlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:41:02 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Phillips <phillips@istop.com>
Cc: linux-kernel@vger.kernel.org, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <200509061836.07813.phillips@istop.com>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <200509061819.45567.phillips@istop.com> <200509070021.29959.ak@suse.de>
	 <200509061836.07813.phillips@istop.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 06 Sep 2005 19:40:44 -0400
Message-Id: <1126050044.5601.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 18:36 -0400, Daniel Phillips wrote:
> But then how would thread_info->task on the irq stack ever get initialized?
> 
> My "what for" question was re why interrupt routines even need a valid 
> current.  I see one answer out there on the web: statistical profiling.  Is 
> that it?

scheduler_tick -  This is called from the timer interrupt, and it
definitely needs a valid current.

-- Steve


