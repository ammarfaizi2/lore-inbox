Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVA1LWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVA1LWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVA1LWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:22:33 -0500
Received: from styx.suse.cz ([82.119.242.94]:28837 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261288AbVA1LW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:22:26 -0500
Date: Fri, 28 Jan 2005 12:24:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050128112445.GB9232@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <d120d50005012706045b2e84af@mail.gmail.com> <20050127161518.GA14020@ucw.cz> <200501280213.13005.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501280213.13005.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 02:13:12AM -0500, Dmitry Torokhov wrote:
> On Thursday 27 January 2005 11:15, Vojtech Pavlik wrote:
> > > I think that the very first path ("while true; do xset led 3; xset
> > > -led 3; done" makes keyboard miss release events and makes it
> > > unusable) should go in 2.6.11 so please do:
> > > 
> > >         bk pull bk://dtor.bkbits.net/for-2.6.11
> > 
> > Pulled, pushed into my tree. I verified the patch, and it is indeed
> > correct. Before we get an ACK for a command we sent, we still may
> > receive normal data. After we got the ACK we know for sure that no more
> > regular data will come, and can expect the command response.
> 
> Hi Vojtech,
> 
> I have another one that I think needs to be in 2.6.11 - in ps2_command
> does not update timeout variable when waiting for the first byte of
> response so even if command times out the code still goes and tries to
> wait for more data. It actually causes problems with GETID command - we
> end up reporting success even if we did not get any response (except for
> initial ACK). 
> 
> Also, now taht wait_event_timeout is available we shoudl use it instead
> of wait_event_interruptible_timeout.
 
OK.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
