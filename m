Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285017AbRLQEPt>; Sun, 16 Dec 2001 23:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285013AbRLQEP3>; Sun, 16 Dec 2001 23:15:29 -0500
Received: from dsl-64-193-154-205.telocity.com ([64.193.154.205]:33540 "EHLO
	fs6.int.nikki.com") by vger.kernel.org with ESMTP
	id <S285007AbRLQEPV>; Sun, 16 Dec 2001 23:15:21 -0500
Message-Id: <sc1d2b03.001@fs6.int.nikki.com>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Sun, 16 Dec 2001 23:14:32 -0500
From: "Jason Rivard" <jrivard@nikki.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Is /dev/shm needed?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I delete all files in /tmp on reboot +
I delete all of <user>'s files in /tmp if <user> has no running
processes when <user> logs out.

>>> "H. Peter Anvin" <hpa@zytor.com> 12/16/01 09:26PM >>>
Followup to:  <E16Fl8j-0000nA-00@phalynx>
By author:    Ryan Cumming <bodnar42@phalynx.dhs.org>
In newsgroup: linux.dev.kernel
>
> On December 16, 2001 15:47, Adam Schrotenboer wrote:
> > I may be wrong about /tmp as well, but I have come to think that it
is data
> > that ought be discarded after logout, and have sometimes considered
writing
> > a script for it in the login/logout scripts.
> 
> System daemons can legally use /tmp, and they may not apprechiate
having 
> their files removed from underneath them everytime someone telnets
in. ;)
> 

Not to mention when you kill a secondary session.  It's bogus.
However, discarding /tmp on *REBOOT* is legitimate.

	 -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/
