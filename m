Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVGKTbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVGKTbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVGKTbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:31:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6022 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262299AbVGKTbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:31:42 -0400
Subject: Re: [PATCH] Fix race in do_get_write_access()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050711161011.GA28238@atrey.karlin.mff.cuni.cz>
References: <20050711161011.GA28238@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121110288.1871.233.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Jul 2005 20:31:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-07-11 at 17:10, Jan Kara wrote:

>   attached patch should fix the following race:
...
>   and we have sent wrong data to disk... We now clean the dirty buffer
> flag under buffer lock in all cases and hence we know that whenever a buffer
> is starting to be journaled we either finish the pending write-out
> before attaching a buffer to a transaction or we won't write the buffer
> until the transaction is going to be committed... Please apply.

Looks good to me.

Btw, how did you find this?  Were you able to reproduce this in
practice?

Cheers,
 Stephen

