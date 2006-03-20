Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWCTJqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWCTJqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 04:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWCTJqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 04:46:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13961 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750751AbWCTJqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 04:46:02 -0500
Date: Mon, 20 Mar 2006 10:46:01 +0100
From: Jan Kara <jack@suse.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix potential null pointer deref in quota
Message-ID: <20060320094601.GA11037@atrey.karlin.mff.cuni.cz>
References: <200603182308.05050.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603182308.05050.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> The coverity checker noticed that we may pass a NULL super_block to
> do_quotactl() that dereferences it.
> Dereferencing NULL pointers is bad medicine, better check and fail 
> gracefully.
  Umm, when do you think we can dereference NULL pointer to a super_block?
check_quotactl_valid() allows sb==NULL only in the case of Q_SYNC command.
And that is handled in do_quotactl() correctly even if sb==NULL...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
