Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWBEFG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWBEFG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 00:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWBEFG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 00:06:29 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:64272 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030270AbWBEFG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 00:06:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Albert Cahalan <acahalan@gmail.com>
Subject: Re: athlon 64 dual core tsc out of sync
Date: Sun, 5 Feb 2006 05:06:28 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com, safemode@comcast.net
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
In-Reply-To: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602050506.28108.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 February 2006 20:24, Albert Cahalan wrote:
> Alistair John Strachan writes:
> > On Saturday 04 February 2006 19:03, Lee Revell wrote:
> >> On Fri, 2006-02-03 at 21:10 -0500, Ed Sweetman wrote:
> >>> I know this has been gone over before, and I am aware of
> >>> the possible fix being the use of the pmtmr.
> >>>
> >>> My question is, if there is support builtin to the kernel for more than
> >>> one timer, and we know that no timer but the pmtimer is reliable on a
> >>> dual core system, why doesn't the startup of the kernel choose the
> >>> pmtimer based on if it detects the system is a dual core proc with smp
> >>> enabled?   And if the pmtimer doesn't fix this sync issue, is there a
> >>> fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot
> >>> args to the kernel results in these messages.
> >>
> >> Excellent question.  What's the status of this bug?  It's a
> >> showstopper for a ton of people on the JACK list...
> >
> > As Andi has recounted many times already, pmtmr is now the
> > default on x86-64 if it's built in. I'm sure you can confirm
> > this from the sources.
>
> That's unhelpful unless you are suggesting that Linux no
> longer supports running the 32-bit kernel on 64-bit hardware.
> If that is the case, it ought to detect the incompatibility
> and refuse to boot.

To be fair, the original poster made no indication that he wasn't running a 
64bit kernel. It's obvious from subsequent posts that he isn't.

While I agree pmtmr is sensible on the X2, unlike on x86-64, x86 supports the 
clock= option for overriding the default.

It's really only installing new distros that might be problematic (in which 
case maybe they can patch the kernel to use pmtmr?).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
