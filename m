Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTLZBYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLZBYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:24:01 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:8196 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264437AbTLZBX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:23:58 -0500
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrea Barisani <lcars@infis.univ.trieste.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel 2.6.0, wrong Kconfig directives
References: <20031222235622.GA17030@sole.infis.univ.trieste.it>
	<87smj8bt6y.fsf@devron.myhome.or.jp>
	<20031225195115.GQ31789@actcom.co.il>
	<87isk4bptp.fsf@devron.myhome.or.jp>
	<20031225203853.GV31789@actcom.co.il>
	<871xqsbnen.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 26 Dec 2003 10:23:41 +0900
In-Reply-To: <871xqsbnen.fsf@devron.myhome.or.jp>
Message-ID: <87n09g9xsy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Muli Ben-Yehuda <mulix@mulix.org> writes:
> 
> > > I see. So why did we need the SOUND_GAMEPORT?
> > 
> > I thought I explained this above, quite verbosely :-) 
> > Rather than make the sound drivers depend directly on GAMEPORT, which
> > is troublesome because Kconfig has no provisions for this type of
> > dependancy, we create an artificial dependency, SOUND_GAMEPORT, which
> > the sound driver depends on. SOUND_GAMEPORT depends on GAMEPORT, and
> > Kconfig ends up doing the right thing. I hope that was clearer. 
> 
> Umm... SOUND_GAMEPORT is always true, so GAMEPORT is just option, not
> dependency.
> 
> It may be good to be documented as the help of Kconfig instead of
> SOUND_GAMEPORT...

Ah, sorry. You are right. I understanded it now.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
