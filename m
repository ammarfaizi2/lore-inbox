Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271189AbTHDFOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHDFOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:14:30 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:25050 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S271189AbTHDFO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:14:28 -0400
Date: Sun, 3 Aug 2003 23:14:22 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: "Ian S. Nelson" <nelsonis@earthlink.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell 2650 Dual Xeon freezing up frequently
In-Reply-To: <3F283E3A.7060200@earthlink.net>
Message-ID: <Pine.LNX.4.44.0308032311290.32298-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Ian S. Nelson wrote:

> I'm running a RedHat 2.4.20 kernel on some 2650's   all dual xeon 
> (pentium 4 jacksonized  so it looks like 4 procsessors)  2 have 1GB of 
> RAM and 1 has 2GB of RAM.   THey all wedge, some times after a few 
> minutes,  sometimes after hours.
> 
> I hooked up a serial consol to capture a kernel panic or something else 
> that would be fun to debug,  no such luck..  It just locks up.  No nothing.
> 
> 
> I'm looking at the 2.4.21 change logs and I'm not seeing aynthing that 
> sounds like it would fix this, a couple possible SMP issues but nothing 
> that identifies Pentium 4 Xeon problems.
> I've added one networking module but the problem happens without it 
> being loaded,    so my crap doesn't smell bad, yet ;-)
> 
> I'm spinning stuff on it in uniprocessor mode at the moment, seeing if 
> that fixes anything.

Try replacing the tg3 driver with the one found in newer kernels (2.4.22pre
or 2.4.21) or make sure you are using the latest RH kernel with the updated
tg3 driver.  Do not use the bcm5700.o driver BTW, it has problems.

Another problem could be the aacraid controller, but they normally have a
lot of noise associated with a hang.  Unfortunately it's unclear at this
time if that is a hardware problem, firmware problem, or driver problem.

Regards
James Bourne

> 
> any free clues?
> 
> 
> thanks,
> Ian
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

