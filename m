Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266998AbTGGNBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267011AbTGGNBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:01:50 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:10136 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266998AbTGGNBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:01:35 -0400
Date: Mon, 7 Jul 2003 14:16:05 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307071424.06393.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0307071408440.5007@skynet>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de>
 <Pine.LNX.4.53.0307071042470.743@skynet> <200307071424.06393.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Daniel Phillips wrote:

> And set up distros to grant it by default.  Yes.
>
> The problem I see is that it lets user space priorities invade the range of
> priorities used by root processes.

That is the main drawback all right but it could be addressed by having a
CAP_SYS_USERNICE capability which allows a user to renice only their own
processes to a highest priority of -5, or some other reasonable value
that wouldn't interfere with root processes. This capability would only be
for applications like music players which need to give hints to the
scheduler.

This would make it a bit Linux specific but as the pam module (currently
vapour I know) is the only piece of code that would be aware of the
distinction, it should not be much of a problem.

-- 
Mel Gorman
