Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSANIxM>; Mon, 14 Jan 2002 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSANIxD>; Mon, 14 Jan 2002 03:53:03 -0500
Received: from [62.245.135.174] ([62.245.135.174]:58043 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S288276AbSANIwz>;
	Mon, 14 Jan 2002 03:52:55 -0500
Message-ID: <3C429C5F.7B549A02@TeraPort.de>
Date: Mon, 14 Jan 2002 09:52:47 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@zip.com.au
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/14/2002 09:52:47 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/14/2002 09:52:54 AM,
	Serialize complete at 01/14/2002 09:52:54 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> Right. And that is precisely why I created the "mini-ll" patch. To
> give the improved "feel" in a way which is acceptable for merging into
> the 2.4 kernel.
> 
> And guess what? Nobody has tested the damn thing, so it's going
> nowhere.
> 
> Here it is again:
> 

 I did. Not standalone, but in the combination of:

2.4.17+preempt+lock-break+vmscan.c+read_latency

 Had to merge/frop some of the changes, as they are already they already
were in lock-break. So far, the stuff works -> no hangs/freezes/oopses.

 My goal in applying this stuff is to get better interactivity and
responsiveness on my laptop (320 MB, eithe 2x or no swap).

 The biggest improvements I had recently was the patch to vmscan.c by
Martin v. Leuwen and the inclusion of the read_latency stuff from Andrea
(?). That basically removed all the memory problems (cache forcing
excessive swapping out) and IO hangs (vmware doing IO freezing system
for 10s of seconds).

 preempt, lock-break and I think mini-ll have further improved the
interactive "feeling". And no, I have no hard data. I am not into
Audio/DVD palyback, so ultra-low worst case latency is not my ultimate
desire. Great VM+IO performance while having great interactivity is :-)
Which probably brings us back to the topic of this thread :-))

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
