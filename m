Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbTCNLsT>; Fri, 14 Mar 2003 06:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbTCNLsS>; Fri, 14 Mar 2003 06:48:18 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4621 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263066AbTCNLsR>; Fri, 14 Mar 2003 06:48:17 -0500
Message-ID: <3E71C47F.1050205@aitel.hist.no>
Date: Fri, 14 Mar 2003 13:01:03 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>   This might cause weird thing to happen, especially on small-memory machines.

Weird things happened.
mm1 (and mm2 on smp) have been running very fine for me. So I decided to 
try mm6 on UP.  The machine have 512M, and uses soft raid-1 on /  The
rest is plain ide disk partitions, all using ext2.

It booted fine.
I fired up openoffice, a 2x-3x speedup ought to be noticeable.
It didn't start, but got stuck with the annoying on-top-of-everything 
splash screen showing.  ps aux showed lpd in D state - perhaps
oo queries lpd.  I also tried mozilla, and it got stuck in D state too.
Openoffice was only in sleep so I killed it.  Mozilla was unkillable
as expected from the D state.

I've heard that this is supposed to be an anticipatory scheduler bug, 
and started looking for information on how to use deadline. But 
everything suddenly came loose and things works normally now.

Openoffice and mozilla starts just fine now.  I guess AS have some
boot trouble, or could it be a jiffy wraparound issue? (Assuming
2.5.64-mm6 starts the counter near a wrap)

Please tell if there's anything I can do to test further.

Helge Hafting




