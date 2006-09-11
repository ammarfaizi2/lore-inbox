Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWIKWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWIKWMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWIKWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:12:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965026AbWIKWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:12:46 -0400
Date: Mon, 11 Sep 2006 15:12:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       stable@kernel.org
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-Id: <20060911151205.9cfcfa2a.akpm@osdl.org>
In-Reply-To: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz>
References: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 23:05:30 +0200
Jan Kara <jack@suse.cz> wrote:

>   here is the patch that came out of the thread "set_page_buffer_dirty
> should skip unmapped buffers". It fixes several flaws in the code
> writing out ordered data buffers during commit. It definitely fixed the
> problem Badari was seeing with fsx-linux test.  Could you include it
> into -mm? Since there are quite complex interactions with other JBD code
> and the locking is kind of ugly, I'd leave it in -mm for a while whether
> some bug does not emerge ;). Thanks.

yup.  Thanks, guys.  I'll take a close look at this.  I'll aim to get it
into 2.6.19-rc1 a week or so after 2.6.18 is released.  Once it has cooked
in mainline for a couple of weeks it should be then suitable for a 2.6.18.x
backport.  That'll be around the 2.6.19-rc2 timeframe.
