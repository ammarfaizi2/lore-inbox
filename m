Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVDLOl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVDLOl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVDLOlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:41:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58560 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262339AbVDLOkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:40:39 -0400
Subject: Re: Problem in log_do_checkpoint()?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jeffm@suse.com,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050411113614.GF1195@atrey.karlin.mff.cuni.cz>
References: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
	 <1112969175.1975.96.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050411113614.GF1195@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113316809.2404.84.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 12 Apr 2005 15:40:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-04-11 at 12:36, Jan Kara wrote:

> > The prevention of multiple writes in this case should also improve
> > performance a little.
> > 
> > That ought to be pretty straightforward, I think.  The existing cases
> > where we remove buffers from a checkpoint shouldn't have to care about
> > which list_head we're removing from; those cases already handle buffers
> > in both states.  It's only when doing the flush/wait that we have to
> > distinguish the two.
>   Yes, AFAICS the changes should remain local to the checkpointing code
> (plus __unlink_buffer()). Should I write the patch or will you?

Feel free, but please let me know if you start.  I'm doing a bit of
chasing of leaks and dealing with that O_SYNC thing for 2.4 right now,
but I'll get back to the checkpoint code after that if you haven't
started by then.

Cheers,
 Stephen

