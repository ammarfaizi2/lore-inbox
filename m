Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWCNWRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWCNWRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWCNWRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:17:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52639
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932520AbWCNWRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:17:43 -0500
Subject: RE: [PATCH] provide hrtimer exports for module use [Was: Exports
	for hrtimer APIs]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A92BAC@scsmsx403.amr.corp.intel.com>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A92BAC@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:18:14 +0100
Message-Id: <1142374694.19916.663.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 14:11 -0800, Stone, Joshua I wrote:
> Sure - SystemTap uses timers to provide an asynchronous probe during
> module execution.  This might be utilized for polling kernel states, for
> flushing trace data, and perhaps other similar uses.  Currently we're
> using the main timer APIs - add_timer, mod_timer, etc.
> 
> My motivation for moving to hrtimer is because of what I read in its
> documentation - basically that the timer wheel is best for timeout cases
> which are rarely recascaded.  The way SystemTap uses timers is more for
> defining intervals, and they are always cascaded until the module is
> complete.  The hrtimers seem more suited to this methodology.

What means "more for defining intervals" ? Which intervals  (period in
ms)? What are the timers used for ?

	tglx


