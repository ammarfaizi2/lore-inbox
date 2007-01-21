Return-Path: <linux-kernel-owner+w=401wt.eu-S1751338AbXAUTAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXAUTAv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAUTAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:00:51 -0500
Received: from thunk.org ([69.25.196.29]:52243 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbXAUTAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:00:51 -0500
Date: Sun, 21 Jan 2007 13:55:35 -0500
From: Theodore Tso <tytso@mit.edu>
To: Willy Tarreau <w@1wt.eu>
Cc: Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070121185534.GE27422@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
	Joe Barr <joe@pjprimer.com>,
	Linux Kernel mailing List <linux-kernel@vger.kernel.org>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu> <20070121055456.GC27422@thunk.org> <20070121070557.GB31780@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070121070557.GB31780@1wt.eu>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 08:05:57AM +0100, Willy Tarreau wrote:
> Hmmm the busy loop is dirty as hell, even on SMP, but it works ;-)
> I remember is was possible to reprogram the RTC to interrupt at 8192 Hz.
> If the task is running with real time prio, it should get this accuracy,
> or am I mistaken ?

You can do in a kernel module.  The problem with a userspace program
is that without the -rt patches, you can't guarantee that userspace
process will get a chance to run in time.

						- Ted
