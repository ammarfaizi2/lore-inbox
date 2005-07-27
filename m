Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVG0BB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVG0BB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVG0BB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:01:56 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:26541 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261802AbVG0BBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:01:55 -0400
Message-ID: <42E6DD0D.4060905@m1k.net>
Date: Tue, 26 Jul 2005 21:02:05 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: astralstorm@gorzow.mm.pl, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>	<42E692E4.4070105@m1k.net>	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>	<42E69C5B.80109@m1k.net> <20050726144149.0dc7b008.akpm@osdl.org> <42E6D7E9.2080408@m1k.net>
In-Reply-To: <42E6D7E9.2080408@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------070602060407080400090809"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602060407080400090809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> However, sometimes there are patches in -mm that are incompatable with 
> -linus.  An example of this is "Pavel's pm_message_t mangling" ... 
> Testing for the numbered 2.6.x version isn't enough of a test in a 
> case like this, but it would be nice to be able to develop against the 
> most recent version of both the -mm tree and the -linus tree without 
> having to revert patches.  Of course, v4l has chosen to maintain 
> compatibility with -mm, for the sake of patch generation, and I have a 
> handy -linus-compat.patch on the side for now if I want to build cvs 
> against -linus, until Pavel's patches get merged later on.  But I'm 
> sure things like this must happen all the time.  How do others deal 
> with issues like these automatically?
>
> It doesn't matter which -mm version or which -linus version it is... I 
> can already test for 2.6.x ... All that matters is if it is -mm or 
> -linus.  If there isn't already an answer to this question, maybe you 
> can create a /linux/.mm file, or something like that.  A Makefile can 
> test for the presence of that file... or is there already a file 
> present that is unique to the -mm tree?
>
Here's a patch, if you so choose to go this route.....

This should NEVER be merged to -linus ;-)

Signed-off-by: Michael Krufky <mkrufky@m1k.net>




--------------070602060407080400090809
Content-Type: text/plain;
 name="mm-only.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-only.patch"

diff -upN a/.mm b/.mm
--- a/.mm	1970-01-01 00:00:00.000000000 +0000
+++ b/.mm	2005-07-26 20:57:41.000000000 +0000
@@ -0,0 +1 @@
+1

--------------070602060407080400090809--
