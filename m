Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUIPNkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUIPNkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIPNkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:40:21 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:45704 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268074AbUIPNgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:36:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Thu, 16 Sep 2004 09:36:01 -0400
User-Agent: KMail/1.7
Cc: Valdis.Kletnieks@vt.edu, "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <1095088378.2765.18.camel@sisko.scot.redhat.com> <200409160634.i8G6YhOR008893@turing-police.cc.vt.edu>
In-Reply-To: <200409160634.i8G6YhOR008893@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160936.01539.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.59.197] at Thu, 16 Sep 2004 08:36:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 02:34, Valdis.Kletnieks@vt.edu wrote:
>On Mon, 13 Sep 2004 16:12:59 BST, "Stephen C. Tweedie" said:
>> Well, we really need to see _what_ error the journal had
>> encountered to be able to even begin to diagnose it.  But
>> 2.6.9-rc1-mm3 and -mm4 had a bug in the journaling introduced by
>> low-latency work on the checkpoint code; can you try -mm5 or back
>> out
>> "journal_clean_checkpoint_list-latency-fix.patch" and try again?
>
>I just got bit by the 'journal aborted' problem under -rc1-mm5, so
> it looks like that particular bug wasn't at fault here (also, I
> started seeing the problem under -mm2, so that's another point
> against that theory...)
>
Thanks Valdis, now I don't feel quite so lonely in this camp. :-)

[...]

>This happened about 4 minutes into a 'tar cf - | (cd && tar xf -)'
> pipeline to clone a work copy of the -rc1-mm5 source tree (it got
> about 408M through the 543M before it blew up)....

Humm, it happened to me while amdump was running, and amdump uses tar.
My tar version is 1.13-25.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
