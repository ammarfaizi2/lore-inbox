Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318008AbSHZHac>; Mon, 26 Aug 2002 03:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHZHac>; Mon, 26 Aug 2002 03:30:32 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:49855 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318008AbSHZHab>;
	Mon, 26 Aug 2002 03:30:31 -0400
Date: Mon, 26 Aug 2002 09:34:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: torvalds@transmeta.com, ralf@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce CONFIG_INPUT as forward symbol
Message-ID: <20020826093428.B2524@ucw.cz>
References: <Pine.LNX.4.33L2.0208252243130.23948-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0208252243130.23948-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Sun, Aug 25, 2002 at 10:59:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 10:59:47PM -0700, Randy.Dunlap wrote:
> 
> Hi,
> 
> I've been using gcml2 from Greg Banks to look at CONFIG_
> variable dependencies in config.in files.
> 
> By moving drivers/input/config.in before drivers/char/Config.in
> and drivers/usb/Config.in for arch/alpha and arch/mips(64),
> several (7) instances of this message:
>   forward declared symbol "CONFIG_INPUT" used in dependency list
> and (6) instances of this one:
>   forward declared symbol "CONFIG_SOUND_GAMEPORT" used in
>   dependency list
> can be removed.  (Yes, the latter one is for OSS drivers,
> so it's not so important.)
> 
> It also adds one forward dependency for a USB joystick
> in the input subsystem [still only for alpha and mips(64)].
> Most other arches are already like this.
> 
> This patch is to 2.5.31-bk7 (jgarzik's latest snapshot).
> Please apply.

I'd like to take a look at the patch - both the symbols are from the
input drivers. Where can I find it? And what was the exact problem?

-- 
Vojtech Pavlik
SuSE Labs
