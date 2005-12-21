Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVLUKVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVLUKVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 05:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVLUKVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 05:21:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41104 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932348AbVLUKVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 05:21:25 -0500
Date: Wed, 21 Dec 2005 11:21:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ordering of suspend/resume for devices.  any clues, anyone?
Message-ID: <20051221102109.GB1735@elf.ucw.cz>
References: <20051215143124.GD14978@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215143124.GD14978@lkcl.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [hi, please kindly cc me direct as i am deliberately subscribed with
> settings to not receive posts from this list, but if that is inconvenient
> for you to cc me, don't worry i can always look up the archives
> to keep track of replies, thank you.]
> 
> http://handhelds.org/moin/moin.cgi/BlueAngel
> 
> works.
> 
> am seeking some advice regarding power management - specifically
> the ordering of devices "resume" functions being called.
> 
> we have an LCD, and an ATI chip.  switching on the LCD powers up
> the ATI chip.
> 
> unfortunately, resume calls the ATI device initialisation
> _before_ the LCD resume initialisation.  the ATI chip's
> initialisation fails - naturally - because it's not even
> powered up.

I'd say "make LCD system/platform device". That will init it first,
shut it down last.
							Pavel

-- 
Thanks, Sharp!
