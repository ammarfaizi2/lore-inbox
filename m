Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVDRJBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVDRJBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVDRJBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:01:06 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:28313 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261993AbVDRJAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:00:10 -0400
X-ORBL: [67.124.119.21]
Date: Mon, 18 Apr 2005 01:59:54 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418085954.GA1236@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <426371B5.2060200@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426371B5.2060200@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 05:37:09PM +0900, Takashi Ikebe wrote:

> As you said, if we can migrate the data to new process without
> stopping service, it is OK, but the real applications need to
> takeover data very much(sometimes it's over gigabyte....depends on
> service, and causes service disruption...).

man mmap
man 5 ipc

> So, live patching seems reasonable to us.

That still doesn't tell me why it's necessary to do something so
complicated

> 2. Activate the patch modules with pannus -a command.
> - stop the target process and check current instruction not to conflict.
> - if it is not conflict, overwrite the jump assembly to function's
>   entrypoiny where you want to fix, to patch module's one.
> - restart the process.

there is a still a stop/start here

why not just hand the state of to a different process?  how is that
slower?

> Will this be answer??

maybe, but i'm far from convinced it's necessary and therefore
warrants a big ugly kernel patch

