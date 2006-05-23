Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWEWNjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWEWNjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEWNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 09:39:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10684 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932070AbWEWNjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 09:39:03 -0400
Date: Tue, 23 May 2006 15:38:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <200605222200.18351.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0605231532330.25086@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> > Any idea why this wasn't done for bzip2?
>> >>
>> >> Yes, the bzip2 author I have been told was originally planning to do
>> >> that, but then thought it would be harder to deploy that way (because
>> >> gzip is a core utility, and people are nervous about making it larger.)
>>
>> I'd say that concern is valid.
>>
>> >It's a bit of a shame bzip2 even exists, really. It really would be better
>> > if there was one unified, pluggable archiver on UNIX (and portables).
>>
>> Would You Like To Contribute(tm)? :)
>> Whenever a program is missing, someone is there to write it.
>
>I would, but if it's a "valid concern" that gzip is a few hundred KB larger, 
>and the community would not graciously receive such work, there's not much 
>point, is there? :-)
>
Make it use shared libraries (did I already mention that?)

BTW, "a few hundred KB" is really overestimated if it's just about bzip2:
-rwxr-xr-x  1 root root 27640 Apr 23 02:20 /usr/bin/bzip2
-rwxr-xr-x  1 root root 66864 Apr 23 02:20 /lib/libbz2.so.1.0.0
That's not even _one_ hundred KB. Oh, just keep it as .so. :)
And of course, compile with klibc, it has less loader bloat than glibc (as 
someone had found out...I think it was Greg.)



Jan Engelhardt
-- 
