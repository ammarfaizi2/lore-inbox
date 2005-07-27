Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVG0Qmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVG0Qmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVG0PkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:40:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262389AbVG0Pjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:39:55 -0400
Subject: Re: Linux BKCVS kernel history git import..
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
	 <1122457238.3027.37.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 16:41:09 +0100
Message-Id: <1122478870.28128.52.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 08:29 -0700, Linus Torvalds wrote:
> I used to think I wanted to, but these days I really don't. One of the
> reasons is that I expect to try to pretty up the old bkcvs conversion some
> time: use the name translation from the old "shortlog" scripts etc, and
> see if I can do some other improvements on the conversion (I think I'll
> remove the BK files - "ChangeSet" etc).

Thomas has done all that; it's on kernel.org already.

> And it's really much easier and more general to have a "graft" facility.  
> It's something that git can do trivially (literally a hook in
> "parse_commit" to add a special parent), and it's actually a generic
> mechanism exactly for issues like this ("project had old history in some
> other format").

Hm, OK. That works and can also be used for the "fake _absence_ of
parent" thing -- if I'm space-constrained and want only the history back
to some relatively recent point like 2.6.0, I can do that by turning the
2.6.0 commit into an orphan instead of also using all the rest of the
history back to 2.4.0. 

-- 
dwmw2

