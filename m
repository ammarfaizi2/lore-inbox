Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSKBTdh>; Sat, 2 Nov 2002 14:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSKBTdh>; Sat, 2 Nov 2002 14:33:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13574 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261208AbSKBTdg>; Sat, 2 Nov 2002 14:33:36 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: swsusp: don't eat ide disks
Date: Sat, 2 Nov 2002 19:39:22 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aq19la$2od$1@penguin.transmeta.com>
References: <20021102184735.GA179@elf.ucw.cz>
X-Trace: palladium.transmeta.com 1036265988 25727 127.0.0.1 (2 Nov 2002 19:39:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Nov 2002 19:39:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021102184735.GA179@elf.ucw.cz>,
Pavel Machek  <pavel@ucw.cz> wrote:
>
>Here's patch to prevent random scribling over disks during
>suspend... In the meantime alan killed (unreferenced at that time)
>idedisk_suspend() and idedisk_release(), so I have to reintroduce
>them.

I _still_ haven't gotten an explanation for the difference between the
do_xxx_suspend and xxxx_suspend, and why we have both.

> Should I go ahead and kill do_idedisk_suspend and related code?

Please.  Along with an explanation of what the differences are, and who
cares, and who calls which, and why having two different versions aren't
needed any more (or if they _are_ needed, explain that). Right now I'm
not applying this patch just because I want an explanation of it (like I
did last time).

The two different cases are just too confusing, I want to be unconfused. 

		Thanks,
			Linus
