Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUEJV5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUEJV5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUEJV5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:57:23 -0400
Received: from finch.doc.ic.ac.uk ([146.169.1.194]:4765 "EHLO
	finch.doc.ic.ac.uk") by vger.kernel.org with ESMTP id S261638AbUEJV4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:56:55 -0400
Message-ID: <409FFAA0.4000301@bluetheta.com>
Date: Mon, 10 May 2004 22:56:48 +0100
From: Andre Ben Hamou <andre@bluetheta.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com> <Pine.LNX.4.58.0405101446570.1156@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.58.0405101446570.1156@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Try:
> 
> 	select (socket + 1, &fds, &fds, &fds, &timeout);
>                                  ^^^^^

That does work, but only as a workaround (and not a universally 
applicable one). Select *should* return upon the closure of either end 
of a socket connection that is in the read-FD-set only (unless I've 
completely misunderstood the various references).

Cheers,

Andre Ben Hamou
Imperial College London

-- 

...and, on the seventh day, God switched off his Mac.
