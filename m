Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWCSF2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWCSF2w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWCSF2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:28:51 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:7206 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1751439AbWCSF2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:28:51 -0500
Date: Sat, 18 Mar 2006 23:28:47 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060319052847.GA1039471@hiwaay.net>
References: <fa.Hkp0U4ooGgE4K2sa/5vVcaD5wTg@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319023610.GA4824@mail.shareable.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Jamie Lokier  <jamie@shareable.org> said:
>rsync is relevant only *after* the power cut, because it checks mtimes
>to see if files are modified.  The method by which rsync writes files
>isn't relevant to this scenario.

To simplify: substitute "rsync" with "backup program".

Any backup software that maintains some type of index of what has been
backed up (for incremental type backups) or even just backs up files
modified since a particular date (e.g. "dump") can miss files modified
shortly before a crash/power cut/unexpected shutdown.  The data may get
modified but since the mtime may not get updated, nothing can tell that
the data has been modified.

rsync is actually a special case, in that you could always force it to
compare contents between two copies.  Most backup software doesn't do
that (especially tape backups).

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
