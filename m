Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272538AbTGaP0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272543AbTGaPZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:25:02 -0400
Received: from main.gmane.org ([80.91.224.249]:15270 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272538AbTGaPYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:24:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] O11int for interactivity
Date: Thu, 31 Jul 2003 17:21:13 +0200
Message-ID: <yw1x7k5yu3h2.fsf@users.sourceforge.net>
References: <200307301038.49869.kernel@kolivas.org> <200307301055.23950.kernel@kolivas.org>
 <200307301108.53904.kernel@kolivas.org>
 <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:QpzKkFIXF2BTvOTroDN4TQ9nowA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Szonyi Calin" <sony@etc.utt.ro> writes:

>>> > Update to the interactivity patches. Not a massive improvement but
>>> more smoothing of the corners.
>>>
>> Here is O11.1int which backs out that part. This was only of minor help
>> anyway so backing it out still makes the other O11 changes worthwhile.
>>
>> A full O11.1 patch against 2.6.0-test2 is available on my website.
>>
>
> A little bit better than O10 but mplayer still skips frames while
> doind a make bzImage in the background

If you used a sane player this wouldn't happen.  Every few seconds
there will be a frame that takes a little longer than average to
decode, and unless the player can all the CPU time it wants, there
will be skips.  The solution is to buffer a few decoded frames
somewhere, preferably in video memory.  That will give you the extra
time to decode the difficult frames, and then catch up with some easy
ones.

If the scheduler can be tweaked so even mplayer does the right thing,
that's good.  It could solve other problems more difficult to address
in the application.

-- 
Måns Rullgård
mru@users.sf.net

