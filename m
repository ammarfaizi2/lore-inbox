Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbTGMNtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbTGMNtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:49:36 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:14276 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S267293AbTGMNtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:49:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: smiler@lanil.mine.nu, Guillaume Chazarain <gfc@altern.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Mon, 14 Jul 2003 00:06:13 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
References: <SO8752FA8VR71YW8IEQOJDXT3Y86D8.3f113765@monpc> <1058097290.12248.40.camel@sm-wks1.lan.irkk.nu>
In-Reply-To: <1058097290.12248.40.camel@sm-wks1.lan.irkk.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307140006.13345.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 21:54, Christian Axelsson wrote:
> On Sun, 2003-07-13 at 12:41, Guillaume Chazarain wrote:
> > Hi Con,
> >
> > I am currently testing SCHED_ISO, but I have noticed a regression:
> > I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
> > X and fvwm prio are 15, but when I move a window it's very jerky.
>
> It's pretty smooth on my desktop (t-bird 1.4, 512mb ram, nvidia)

Probably faster hardware. I think I'll decrease the iso penalty to just 1/2 
sized timeslices (ISO_PENALTY 2)

> > BTW2, you all seem to test interactivity with xmms. Just for those like
> > me that didn't noticed, I have just found that it skips much less with
> > alsa's OSS emulation than with alsa-xmms.
>
> I will try that out, seems to work so far, intressting...

The logical conclusion of this idea where there is a dynamic policy assigned 
to interactive tasks is a dynamic policy assigned to non interactive tasks 
that get treated in the opposite way. I'll code something for that soon, now 
that I've had more feedback on the first part.

Con

