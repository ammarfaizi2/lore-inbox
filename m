Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTKFP7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKFP7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:59:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10880 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263679AbTKFP7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:59:37 -0500
Date: Thu, 6 Nov 2003 16:59:36 +0100
From: Jan Kara <jack@suse.cz>
To: Alex Lyashkov <shadow@itt.net.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ext3 + diskquta + sync = deadlock
Message-ID: <20031106155936.GB25830@atrey.karlin.mff.cuni.cz>
References: <200311060744.23189.shadow@itt.net.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311060744.23189.shadow@itt.net.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I tred to test stabilyty of ext3 filesystem with high load.
> 
> at one console do start/stop some programs.
> at second console start script
> ===
> while [ 1 ]; do
> mount -o remount,usrquota,grpquota /
> sleep 5
> done;
> ===
> for test how work fs sync.
> After small time (less 10 min) i tred logon on third console and system been 
> locked.
> I use RH kernel 2.4.18-27.x on RH 7.3 box.
> logs tasks states in deadlock attached in mail.
  Hmm... We had some deadlock in 2.4.18 (and still have one nasty in
2.4.23) but from the traces this looks different. I'll try to reproduce it.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
