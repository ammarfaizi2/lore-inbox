Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTESKYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTESKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:24:31 -0400
Received: from zero.aec.at ([193.170.194.10]:1285 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261842AbTESKYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:24:31 -0400
Date: Mon, 19 May 2003 12:37:17 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@muc.de>, kraxel@suse.de, jsimmons@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030519103717.GC15709@averell>
References: <20030515145640.GA19152@averell> <m1of2233ds.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1of2233ds.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 12:58:39AM +0200, Eric W. Biederman wrote:
> I don't know if this affects the frame buffers per se.
> 
> But often BIOS's on systems with large amounts of memory configure
> overlapping mtrrs (where an uncacheable mtrr would override a larger
> cacheable range).  To date this has confused the linux mtrr code when
> it tries to modify things, and you cannot properly setup mtrrs.    I
> believe this applies to both the fb case as well as X.

Interesting. Perhaps it would be really better to use change_page_attr()
with PAT for this. It would avoid these problems.

-Andi
