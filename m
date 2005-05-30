Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVE3OkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVE3OkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVE3OkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:40:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:30104 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261612AbVE3Ojv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:39:51 -0400
Date: Mon, 30 May 2005 16:39:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050530143950.GA1651@ucw.cz>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526154509.GB9443@animx.eu.org> <20050526155344.GB3694@ucw.cz> <20050530142515.GA20372@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530142515.GA20372@animx.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:25:15AM -0400, Wakko Warner wrote:
> Vojtech Pavlik wrote:
> > On Thu, May 26, 2005 at 11:45:09AM -0400, Wakko Warner wrote:
> > > I do wish they'd fix it, because I use this key (kinda like another ALT key)
> > > more than my compose key (again, the menu key, not the right win logo key)
> >  
> > This patch should fix it.
> 
> At work, I have a USB keyboard with 8 extra keys.  Could something like this
> be the cause of about 5 of those keys not working?  (They worked under 2.4
> perfectly)

No. This bug affects PS/2 (AT) keyboards only.

You can try 'evtest' to see if the keys are at least picked up by the
input subsystem. If not, then adding DEBUG to hid-input.h will tell
more. If yes, then they get lost between kernel and X.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
