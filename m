Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316513AbSEUFJ1>; Tue, 21 May 2002 01:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316514AbSEUFJ0>; Tue, 21 May 2002 01:09:26 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:34318 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316513AbSEUFJZ>; Tue, 21 May 2002 01:09:25 -0400
Message-Id: <200205210507.g4L570948949@aslan.scsiguy.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Peter Chubb <peter@chubb.wattle.id.au>, trivial@rustcorp.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Allow aic7xx firmware to be built from BK tree. 
In-Reply-To: Your message of "Mon, 20 May 2002 23:48:56 CDT."
             <Pine.LNX.4.44.0205202339300.1673-100000@chaos.physics.uiowa.edu> 
Date: Mon, 20 May 2002 23:07:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, 20 May 2002, Justin T. Gibbs wrote:
>
>> >This patch removes the two generate files (that are also in the
>> >distributed kernel) before attempting to regenerate them.
>> 
>> Why is this necessary?
>
>Well, I'll take Keith Owen's role and answer:
>
>Some people are using source control management systems which
>leave the managed files read-only.

These people shouldn't be rebuilding the firmware. 8-)

>Some developers use bitkeeper these days, and it'll show exactly this
>problem. I suppose the only reason that not more people complain about it
>is that hardly anyone has set CONFIG_AIC7XXX_BUILD_FIRMWARE=y.

Which is the default.  Those enabling this feature get what they get
as is documented in Configure.help (or at least was in 2.4.X).

>The correct way to fix this is to not overwrite the shipped files. The
>appended patch is a suggestion on how to avoid the mentioned problems.

>(I should pay credit to Keith Owens, since he proposed a similar solution
>before)

Only with lots of MD5 junk and other complicated rules.  I have no problem
with changing the name of the shipped files and using a link if that will
finally put this issue to rest.

--
Justin
