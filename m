Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUBQTv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUBQTv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:51:56 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:45956 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266547AbUBQTvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:51:54 -0500
Message-ID: <40327054.5020303@t-online.de>
Date: Tue, 17 Feb 2004 20:49:40 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, Ryan Reich <ryanr@uchicago.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1pw4i-hM-27@gated-at.bofh.it> <1pw4i-hM-29@gated-at.bofh.it> <1pw4i-hM-31@gated-at.bofh.it> <1pw4i-hM-25@gated-at.bofh.it> <1pLmG-4E7-5@gated-at.bofh.it> <1pRLz-21o-33@gated-at.bofh.it> <1pRVi-2am-27@gated-at.bofh.it> <1pWi8-65a-11@gated-at.bofh.it> <40315225.3010104@uchicago.edu> <4031B01B.80006@t-online.de> <20040217160226.GB2178@mars.ravnborg.org>
In-Reply-To: <20040217160226.GB2178@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Tzn+FiZrZe7iMjmoUQYUuNiMqzj81DwAYeR7SnE7sXG843GTw+zMQ0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> When 2.7 opens I will try to find out if we can rename all victims.
> I can tweak kbuild to warn for modules using '-', so we in the
> end can get rid of this inconsistency.
> 
> Rusty - do you see any problems with this?
> 
> 	Sam
> 
Any chance to get this warning for 2.6?

What would happen if a symbol filename is changed by replacing
the '-' with '_'?

The module-init-tools wouldn't care. I don't know the internals
of kudzu, but discover2 uses modprobe to load the modules. The
internal workarounds in discover2 for the inconsistency would
become obsolete.

Maybe the alsa stuff? There are many alsa modules with '-'.

Would it be easier to fix the output of /proc/modules than
renaming all modules with '-'?


Of course I would be glad to help.


Regards

Harri
