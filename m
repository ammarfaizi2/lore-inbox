Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVIGIWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVIGIWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIGIWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 04:22:13 -0400
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:42696 "EHLO
	hoboe1bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751182AbVIGIWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 04:22:13 -0400
Date: Tue, 6 Sep 2005 23:41:02 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
Message-ID: <20050906214102.GQ19487@infomag.infomag.iguana.be>
References: <20050903200443.GO19487@infomag.infomag.iguana.be> <1125778302.3223.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125778302.3223.29.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjen,

> this looks ENTIRELY like the wrong solution!

To be honoust: I'm not in favour of using refcounts unnecessarily either.

> Isn't it a LOT easier to just del_timer_sync() the timer from the module
> exit code? Mucking with module refcounts in a driver is almost always a
> sign of a bug or at least really bad design, and I think that is the
> case here.....

However, the goal is to make sure that the "watchdog" stays running and
watches the system and that it in case of abnormal behaviour reboots the system.
And you can't get that if you delete the timer.

Greetings,
Wim.

