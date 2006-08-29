Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWH2EMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWH2EMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWH2EMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:12:37 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:9144 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751079AbWH2EMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:12:36 -0400
Date: Tue, 29 Aug 2006 06:05:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Reiser4 und LZO compression
In-Reply-To: <1156801705.2969.6.camel@nigel.suspend2.net>
Message-ID: <Pine.LNX.4.61.0608290603330.8045@yvahk01.tjqt.qr>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>  <44F322A6.9020200@namesys.com>
 <20060828173721.GA11332@hello-penguin.com>  <44F332D6.6040209@namesys.com>
 <1156801705.2969.6.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>Hmm.  LZO is the best compression algorithm for the task as measured by
>> >>the objectives of good compression effectiveness while still having very
>> >>low CPU usage (the best of those written and GPL'd, there is a slightly
>> >>better one which is proprietary and uses more CPU, LZRW if I remember
>> >>right.  The gzip code base uses too much CPU, though I think Edward made
>> > 
>> > I don't think that LZO beats LZF in both speed and compression ratio.
>> > 
>> > LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
>> > of LZO for the next generation suspend-to-disk code of the Linux kernel.
>> > 
>> > see: http://www.goof.com/pcg/marc/liblzf.html
>> 
>> thanks for the info, we will compare them
>
>For Suspend2, we ended up converting the LZF support to a cryptoapi
>plugin. Is there any chance that you could use cryptoapi modules? We
>could then have a hope of sharing the support.

I am throwing in gzip: would it be meaningful to use that instead? The 
decoder (inflate.c) is already there.

06:04 shanghai:~/liblzf-1.6 > l configure*
-rwxr-xr-x  1 jengelh users 154894 Mar  3  2005 configure
-rwxr-xr-x  1 jengelh users  26810 Mar  3  2005 configure.bz2
-rw-r--r--  1 jengelh users  30611 Aug 28 20:32 configure.gz-z9
-rw-r--r--  1 jengelh users  30693 Aug 28 20:32 configure.gz-z6
-rw-r--r--  1 jengelh users  53077 Aug 28 20:32 configure.lzf


Jan Engelhardt
-- 
