Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWEZOAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWEZOAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWEZOAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:00:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:60308 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWEZOAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:00:21 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
References: <348469535.17438@ustc.edu.cn>
	<20060525084415.3a23e466.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 26 May 2006 16:00:14 +0200
In-Reply-To: <20060525084415.3a23e466.akpm@osdl.org>
Message-ID: <p73irns7uoh.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> These are nice-looking numbers, but one wonders.  If optimising readahead
> makes this much difference to postgresql performance then postgresql should
> be doing the readahead itself, rather than relying upon the kernel's
> ability to guess what the application will be doing in the future.  Because
> surely the database can do a better job of that than the kernel.

With that argument we should remove all readahead from the kernel? 
Because it's already trying to guess what the application will do. 

I suspect it's better to have good readahead code in the kernel
than in a zillion application.

-Andi
