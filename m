Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262979AbSJBGE3>; Wed, 2 Oct 2002 02:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262980AbSJBGE3>; Wed, 2 Oct 2002 02:04:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:58016 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262979AbSJBGE2>;
	Wed, 2 Oct 2002 02:04:28 -0400
Date: Wed, 2 Oct 2002 08:09:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: input layer strangeness
Message-ID: <20021002080952.B17477@ucw.cz>
References: <3D9A74CF.8C8585E7@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D9A74CF.8C8585E7@digeo.com>; from akpm@digeo.com on Tue, Oct 01, 2002 at 09:23:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:23:43PM -0700, Andrew Morton wrote:
> 
> It's been doing this ever since the input layer changes:
> 
> - open a few xterms
> - press the spacebar, leave pressed
> - start waggling the mouse about
> - stop pressing spacebar, keep waggling the mouse about,
>   across the xterms
> 
> The keystrokes *never* stop coming.  Just the continuous mouse
> activity causes a stream of keyboard input, at seemingly the normal
> autorepeat rate. I can keep them coming for 30 seconds, just by
> moving the mouse.

Do they stop coming when you stop moving the mouse or they don't stop at
all? The first would be quite interesting, the second would probably be
a missed key release event due to keyboard controller overload by the
mouse.

> In practice, it's irritating because it's quite easy to get a
> stream of erroneous input dumped into the wrong windows.
> 
> It's a vanilla dual pentium with an AT keyboard and a PS/2
> mouse.

Can you check if it happens also on UP? Just want to know if it might be
a SMP issue ...

-- 
Vojtech Pavlik
SuSE Labs
