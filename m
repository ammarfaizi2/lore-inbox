Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHBTMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHBTMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUHBTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:12:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261875AbUHBTMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:12:05 -0400
Date: Mon, 2 Aug 2004 15:11:27 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andi Kleen <ak@muc.de>
cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Patch for review] BSD accounting IO stats
In-Reply-To: <m3r7qpsoa4.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0408021509520.25305-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Andi Kleen wrote:

> This doesn't look very useful, because most writes which
> are flushed delayed would get accounted to pdflushd.

> If you really wanted to do this i guess you would need to 
> track the pid of the process and account it there.

It may be easier to do this at write(2) time, making the
assumption that most IO done there will eventually hit
the filesystem.

Not sure what to do at read time, the current code may
well be good enough.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

