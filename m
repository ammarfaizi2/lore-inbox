Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWANUeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWANUeM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWANUeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:34:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751085AbWANUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:34:11 -0500
Date: Sat, 14 Jan 2006 21:34:10 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jeffm@suse.com
Subject: Re: reiserfs mount time
Message-ID: <20060114203410.GB21901@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> brought to attentino on an irc channel, reiser seems to have the largest 
> mount times for big partitions. I see this behavior on at least two 
> machines (160G, 250G) and one specially-crafted virtual machine
> (a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
> Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
> from http://linuxgazette.net/122/TWDT.html#piszcz
> So, any hint from the reiserfs developers how come reiserfs takes so long?
> Standard mkreiserfs options (none extra passed).
  If I remember correctly, the problem is reiserfs loads bitmaps on mount
and that takes most of the time. Jeff Mahoney <jeffm@suse.com> has
patches fixing this but I think Hans rejected them because he wants only
bugfixes in reiser3...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
