Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVCQMPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVCQMPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVCQMOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 07:14:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:21644 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261300AbVCQMNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 07:13:48 -0500
Date: Thu, 17 Mar 2005 13:14:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
Message-ID: <20050317121435.GA3681@ucw.cz>
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org> <4237FFE4.4030100@aitel.hist.no> <20050316173054.GD1608@ucw.cz> <42396569.6040509@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42396569.6040509@aitel.hist.no>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 12:09:29PM +0100, Helge Hafting wrote:

> Not sure what is correct here, but:
> evtest /dev/input/event0 produce events for all keys on the keyboard.
> Both the normal pc-105 keys, silly extra keys like "favourites", "shopping",
> etc., and the wheels.  The "volume" wheel generates VolumeUp and
> VolumeDown keypresses (and releases.) The other wheels generates
> the same events as the up-arrow and down-arrow keys.

In that case you don't need the wheel support in the atkbd.c driver. 

It's for keyboards that generate the "Wheel +1" "Wheel -1" events like a
mouse would.

> evtest on /dev/input/event1 gives me events from the mouse.
> mouse0, mouse1 and mouse2 cannot be used with evtest.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
