Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTK0GHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 01:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTK0GHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 01:07:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12307 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264432AbTK0GHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 01:07:41 -0500
Date: Thu, 27 Nov 2003 07:07:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Pravin Nanaware , Gurgaon" <pnanaware@ggn.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
Message-ID: <20031127060724.GA31322@alpha.home.local>
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't believe in copy protection at all because what your program can read,
other programs can read, and what your program can test, others can trick it
into not testing it anymore.

However, there was a solution that I found clever : the weak bit. Basically,
a floppy was written with a special controller, and one sector had invalid
states that could randomly be read either 0 or 1 by the drive. The software
then tried to read the same sector 10 times and expected the contents to
change due to the controller's inability to identify the data as clear 0 or 1.
A copy of the floppy would definitely fix the contents to what was read at the
copy time, so the software would not see any more changes during its read test
and would conclude that it was a copy.

I'm not certain that this was fully compatible with all drives and/or
controllers, because there's always a risk of some hardware always reporting
0's or 1's on this sector, but I found the concept original.

Of course, it took the editor far more time to develop this solution than the
crackers to "fix" the software. You know, launch debug, replace the offending
JZ with a JMP or with a NOP/NOP...

Sincerely, I don't think you want to spend so much time developping something
which can be broken within a few minutes.

Regards,
Willy

