Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVGSUVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVGSUVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGSUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:21:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43460 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261687AbVGSUUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:20:10 -0400
Date: Tue, 19 Jul 2005 22:20:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: randy_dunlap <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] 'patchview' script
In-Reply-To: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0507192216120.16157@yvahk01.tjqt.qr>
References: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Someone asked me about a tool like this and I didn't know of one,
>so I made this little script.
>
>'patchview' merges a patch file and a source tree to a set of
>temporary modified files.  This enables better patch (re)viewing
>and more viewable context.  (hopefully)
>
>Are there already other tools that do something similar to this?
>(other than SCMs)

I use unionfs for this purpose because it avoids copying around the full 
kernel tree. This is also good for applying or rediffing in general, since 
after you unmount the union, the "delta directory" contains only modified 
files and you can use diff -Pdpru 2.6.13-rc1 deltadir to get a PGP - a pretty 
good patchfile. :)



Jan Engelhardt
-- 
