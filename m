Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbVKRSbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbVKRSbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbVKRSbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:31:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17289 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161112AbVKRSbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:31:43 -0500
Date: Fri, 18 Nov 2005 19:31:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bj?rn Mork <bjorn@mork.no>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051118183126.GA20793@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com> <20051118114032.GD15825@elf.ucw.cz> <87psoytbtt.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psoytbtt.fsf@obelix.mork.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
> >
> > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > know if 30 seconds timeout helps.
> 
> It does.  

Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
guess it gets wrong timing by design. Question is what to do with
that. Could we make keyboard driver pause the boot until it is done
resetting hardware? Or we can increase the timeout... would 10 seconds
be enough?
								Pavel
-- 
Thanks, Sharp!
