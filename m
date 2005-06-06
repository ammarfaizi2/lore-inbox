Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVFFVu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVFFVu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVFFVuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:50:25 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:12488 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261704AbVFFVsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:48:00 -0400
Message-ID: <42A4C85F.2040509@freemail.hu>
Date: Tue, 07 Jun 2005 00:04:15 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Mousedev or hiddev problem, was: Re: USB mice do not work on 2.6.12-rc5-git9,
 -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu>	<42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <42A2BC4B.5060605@freemail.hu> <42A2CF27.8000806@freemail.hu> <42A3176F.9030307@freemail.hu> <42A4B328.1010400@freemail.hu>
In-Reply-To: <42A4B328.1010400@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Zoltan Boszormenyi írta:
> All the -bk7+ kernels I tried produced the same strange bug
> on my system: after gpm started I was able to move the
> pointer on the screen but when X started up, it's pointer froze.

it turned out that there is nothing wrong with USB on my system.

But someone broke the /dev/input/mouseX <-> USB mouse interaction
in 2.6.11-bk7 and my two-headed system with two X servers were
manually set up to use the distinct mouse devices so the two heads
do not interfere.

No wonder gpm works, it reads /dev/input/mice. Starting only
one X and using /dev/input/mice I found no problems. Setting it
back to /dev/input/mouse0, the mouse pointer is dead again.

Someone deserves a mousebite...

Best regards,
Zoltán Böszörményi
