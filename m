Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWEVVAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWEVVAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWEVVAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:00:08 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:58384 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750940AbWEVVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:00:07 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Linux Kernel Source Compression
Date: Mon, 22 May 2006 22:00:18 +0100
User-Agent: KMail/1.9.1
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605222200.18351.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 21:24, Jan Engelhardt wrote:
> >> > Any idea why this wasn't done for bzip2?
> >>
> >> Yes, the bzip2 author I have been told was originally planning to do
> >> that, but then thought it would be harder to deploy that way (because
> >> gzip is a core utility, and people are nervous about making it larger.)
>
> I'd say that concern is valid.
>
> >It's a bit of a shame bzip2 even exists, really. It really would be better
> > if there was one unified, pluggable archiver on UNIX (and portables).
>
> Would You Like To Contribute(tm)? :)
> Whenever a program is missing, someone is there to write it.

I would, but if it's a "valid concern" that gzip is a few hundred KB larger, 
and the community would not graciously receive such work, there's not much 
point, is there? :-)

Seriously, though, if I understand gzip correctly, it uses deflate/zlib 
internally. Why, in that case, does /bin/gzip not (dynamically) link against 
libz? If a first step was fixing that, a second could be linking dynamically 
against libbz2 and 'liblzma', and making it all compile-time configurable.

That should keep everybody happy.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
