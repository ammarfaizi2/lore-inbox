Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTAZAkx>; Sat, 25 Jan 2003 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTAZAkx>; Sat, 25 Jan 2003 19:40:53 -0500
Received: from hughes-fe01.direcway.com ([66.82.20.91]:20355 "EHLO
	hughes-fe01.direcway.com") by vger.kernel.org with ESMTP
	id <S266069AbTAZAkw>; Sat, 25 Jan 2003 19:40:52 -0500
Subject: Re: 2.5.59-mm5 hangs on boot
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030125153217.6ff6e275.akpm@digeo.com>
References: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com> 
	<20030125153217.6ff6e275.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jan 2003 19:49:46 -0500
Message-Id: <1043542198.3019.4.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-25 at 18:32, Andrew Morton wrote:
> First up, please see if changing this:
> 
> 	static int antic_expire = HZ / 25;
> 
> to
> 
> 	static int antic_expire = 0;
> 
> in drivers/block/deadline-iosched.c fixes it up.

This worked, but this is obviously not a real fix right?  Just to show
that that's where the problem is I guess.

I'll gladly test other patches.

Thanks,
Tom


