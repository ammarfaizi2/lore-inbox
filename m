Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWEWPaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWEWPaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWEWPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:30:25 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:2833 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751358AbWEWPaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:30:24 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Linux Kernel Source Compression
Date: Tue, 23 May 2006 16:28:32 +0100
User-Agent: KMail/1.9.1
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222200.18351.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605231532330.25086@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605231532330.25086@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605231628.32022.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 14:38, Jan Engelhardt wrote:
> >> >> > Any idea why this wasn't done for bzip2?
> >> >>
> >> >> Yes, the bzip2 author I have been told was originally planning to do
> >> >> that, but then thought it would be harder to deploy that way (because
> >> >> gzip is a core utility, and people are nervous about making it
> >> >> larger.)
> >>
> >> I'd say that concern is valid.
> >>
> >> >It's a bit of a shame bzip2 even exists, really. It really would be
> >> > better if there was one unified, pluggable archiver on UNIX (and
> >> > portables).
> >>
> >> Would You Like To Contribute(tm)? :)
> >> Whenever a program is missing, someone is there to write it.
> >
> >I would, but if it's a "valid concern" that gzip is a few hundred KB
> > larger, and the community would not graciously receive such work, there's
> > not much point, is there? :-)
>
> Make it use shared libraries (did I already mention that?)

Actually I did, in the paragraph that you just snipped.

> BTW, "a few hundred KB" is really overestimated if it's just about bzip2:
> -rwxr-xr-x  1 root root 27640 Apr 23 02:20 /usr/bin/bzip2
> -rwxr-xr-x  1 root root 66864 Apr 23 02:20 /lib/libbz2.so.1.0.0
> That's not even _one_ hundred KB. Oh, just keep it as .so. :)
> And of course, compile with klibc, it has less loader bloat than glibc (as
> someone had found out...I think it was Greg.)

Agreed. However gzip is such an ancient (and presumably now secure) tool that 
it might be unpopular to modify it so heavily. It might also be desirable for 
embedded folks to statically link code.

But, this is now seriously OT for LKML, so I might just email the GNU gzip 
folks and see whether it's been done before and/or whether it's a good idea.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
