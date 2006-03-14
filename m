Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWCNWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWCNWsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWCNWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:48:41 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15008
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1752032AbWCNWsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:48:41 -0500
Subject: RE: [PATCH] provide hrtimer exports for module use [Was:
	Exportsfor hrtimer APIs]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A92C2B@scsmsx403.amr.corp.intel.com>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A92C2B@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:49:07 +0100
Message-Id: <1142376547.19916.673.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 14:34 -0800, Stone, Joshua I wrote:
> Thomas Gleixner wrote:
> > What means "more for defining intervals" ? Which intervals  (period in
> > ms)? What are the timers used for ?
> 
> The user can write a block of code that they would like to be executed
> repeatedly in fixed intervals.  A trivial example might look like this:
>     probe timer.ms(10) { flush_data(); }
> 
> This would flush the data every 10ms.
> 
> A example of polling might be:
>     probe timer.ms(1) { log(scheduler_queue_length()); }
> 
> I hope this answers your questions...

Not all all.

I have no clue where the block of code written by the user is executed
and why it needs exports. When a user writes code he can use the
existing userpsace interfaces, so why does the module need that
exports ?

	tglx


