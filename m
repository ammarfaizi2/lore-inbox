Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTEZBAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEZBAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 21:00:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61452 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263857AbTEZBAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 21:00:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Date: 26 May 2003 01:13:05 GMT
Organization: Transmeta Corp
Message-ID: <1053911585.367899@palladium.transmeta.com>
References: <20030525112150.3994df9b.l.s.r@web.de> <3ED0FC58.D1F04381@gmx.de> <20030525210509.09429aaa.l.s.r@web.de>
X-Trace: palladium.transmeta.com 1053911585 29038 127.0.0.1 (26 May 2003 01:13:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 May 2003 01:13:05 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030525210509.09429aaa.l.s.r@web.de>,
René Scharfe  <l.s.r@web.de> wrote:
>
>Anyway, I corrected this. Patch below contains a "BSD-compatible" version,
>and also a strlcat().

Ok, I did my own versions, since (a) I had already started and your
patches wouldn't apply, and (b) I hate adding a zillion lines of extra
copyright notices for a 5-line function and (c) I think your patch had
EXPORT_SYMBOL wrong.

In particular, if any architecture ever decides to roll their own
version of strlcpy/strlcat, the EXPORT_SYMBOL() in ksyms.c would be the
wrong thing to do. 

The current BK tree has my totally untested versions of these functions
("Famous last words: 'how hard can it be?'"), along with what I think
is the proper way to export them.

			Linus
