Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131340AbRAFMCl>; Sat, 6 Jan 2001 07:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131390AbRAFMCc>; Sat, 6 Jan 2001 07:02:32 -0500
Received: from [213.167.219.235] ([213.167.219.235]:43524 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S131340AbRAFMCZ>; Sat, 6 Jan 2001 07:02:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0: apache doesn't start
In-Reply-To: <3A5700C4.2A6D867B@colorfullife.com>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 06 Jan 2001 13:03:29 +0100
In-Reply-To: Manfred's message of "Sat, 06 Jan 2001 12:25:56 +0100"
Message-ID: <87y9wo7ur2.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Manfred" == Manfred  <manfred@colorfullife.com> writes:

    > I found this in another mail:
    > Kevin Fenzi wrote:
    >> Duh. 
    >> 
    >> I figured out the problem. In 2.4.0-test13-pre3 is the introduction of 
    >> the shmall sysctl. I had installed a package called powertweak a while 
    >> back. It looks like powertweak sets any sysctl it doesn't know to 0. 
    >> 
    >> So, the problem was that there was no shared memory for X. ;( 
    >> 
    >> I set that up to a reasonable level and all is well. 
    >> 
    >> sorry for the wild goose chase. :( 
    >> 
    >> kevin 
    >> - 

    > Could you check your /proc/sys/kernel/shmall value?
    > If 2.4 is really incompatible with powertweak, perhaps a warning should
    > be added to the release notes.


yes, it was at 0. I echoed 8 millions into it, and now apache
starts. I had no problem with X though.
And, yes, I do have powertweak installed. 
It can be configured by editing /etc/powertweak.config directly,
because powertweak-config looks like it is not finished yet (at least
in Debian).

What is a reasonable value to put in there ?

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0 #1 Fri Jan 5 22:35:41 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
