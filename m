Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130096AbRB1IWj>; Wed, 28 Feb 2001 03:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130102AbRB1IW2>; Wed, 28 Feb 2001 03:22:28 -0500
Received: from www.wen-online.de ([212.223.88.39]:54290 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130096AbRB1IWV>;
	Wed, 28 Feb 2001 03:22:21 -0500
Date: Wed, 28 Feb 2001 06:25:51 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Shawn Starr <spstarr@sh0n.net>
cc: <shawn@rhua.org>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Causes more then
 just  msgs
In-Reply-To: <Pine.LNX.4.30.0102271651290.7968-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33.0102280619030.1028-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Shawn Starr wrote:

> When added with BUG(); it will hang /dev/dsp.

If the device is opened and we oops before closing it, subsequent
open attempts will fail (busy).  If it hangs after a failed high
order allocation attempt without the BUG() insertion, that could
be called a driver bug.

	-Mike

