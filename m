Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289043AbSAOLit>; Tue, 15 Jan 2002 06:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSAOLij>; Tue, 15 Jan 2002 06:38:39 -0500
Received: from [62.245.135.174] ([62.245.135.174]:24508 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S289080AbSAOLiW>;
	Tue, 15 Jan 2002 06:38:22 -0500
Message-ID: <3C4414A7.8A3FF2FE@TeraPort.de>
Date: Tue, 15 Jan 2002 12:38:15 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: russ@elegant-software.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/15/2002 12:38:15 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/15/2002 12:38:22 PM,
	Serialize complete at 01/15/2002 12:38:22 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> This is getting silly ... feeback like "ll is better than PK", "feels
> smooth", "is reponsive", "my kernel
> compile is faster than yours", etc. is not getting us any closer to the
> "how" of making a better kernel.
> 
> What's the goal? How should SMP and NUMA behave? How is success measured?
> 
> It would be good to be very clear on the ultimate purpose before making
> radical changes. All of
> these changes are dancing around some vague concept of
> reponsiveness...so define it!
>

 OK, just my set of goals/requirements for a usable/production kernel:

- working VM under a broad set of loads. Working means fair/fitting
treatment of cache vs. process memory, no OOM killing processes when
there is plenty memory in "free+buffer+cache", no unnecessary swapping
out of processes if there is plenty of "free+buffer+cache" memory.
- good/great interactive feel. This means no loss of interactivity due
to cache vs. process memory issues. This means no loss of interactivity
due to heavy IO.
- Good enough worst case latency for "amateur" audio/DVD playback.

 What *I* do not need it "hard real-time" with 101% guaranteed response
times.

 What *I* want is to see my goals in the stock kernel, without needing
to apply a weird set of patches :-)

 How we get there I do not care to much. If -aa can solve the VM
problems, fine. If rmap solves them, great. Just bring a working,
maintainable solution in.

 Ditto for LL vs. preempt.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
