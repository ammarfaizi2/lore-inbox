Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWJWRMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWJWRMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWJWRMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:12:39 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:46989 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S964929AbWJWRMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:12:38 -0400
Message-ID: <453CF7C8.2000600@gmail.com>
Date: Mon, 23 Oct 2006 19:11:36 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: teunis <teunis@wintersgift.com>, xboom <art@usfltd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc2-git7 shutdown problem
References: <20061022145210.n736g78k42e8ggkg@69.222.0.225> <Pine.LNX.4.64.0610221356440.3962@g5.osdl.org> <453C2903.1060906@wintersgift.com> <Pine.LNX.4.64.0610230755010.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610230755010.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.46.250
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 22 Oct 2006, teunis wrote:
>> Hash: SHA1
>>
>> Linus Torvalds wrote:
>>> On Sun, 22 Oct 2006, art@usfltd.com wrote:
>>>> 2.6.19-rc2-git7 shutdown problem
>>>>
>>>> below are last shutdown messages - system is hunging forever !
>>>> hda was mounted, hdb not
>>>> any clue ?
>>> Noting springs to mind immediately.
>>>
>>> Can you narrow this down more specifically? Did you test 2.6.19-rc2-git6, 
>>> and that was fine? Or did you just happen to test -git7, and the previous 
>>> kernel you did this on was some much older one?
>> I'm seeing the same thing here between rc2-git6 and rc2-mm2 on intel
>> 945-based hardware and similar.   (rc2-git6 WORKS, rc2-mm2 FAILS)
>> rc2-git6: for the most part works fine.
>> rc2-mm2: Restart works - shutdown freezes.

[snip]

> Final note: it doesn't _have_ to be x86/IDE changes. There are other 
> things there that just sound less likely: the wireless networking merge, 
> and a small patch-series through Andrew. So if somebody doesn't 
> immediately step up, a few reboots with the "git bisect" thing really 
> would help.

Just to another-confirm the problem, I have this too. The sysrq-t shows only
swapper with trace showing some lock function called, I have a screenshot of
this, but not here and I can't post it (not even test anything) till Thursday,
sorry.
I think, the screenshot was taken in shutdown process of 2.6.19-rc2-mm1.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
