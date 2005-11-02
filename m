Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVKBQLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVKBQLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVKBQLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:11:39 -0500
Received: from verein.lst.de ([213.95.11.210]:34774 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965111AbVKBQLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:11:38 -0500
Date: Wed, 2 Nov 2005 17:11:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] TIOC* compat ioctl handling
Message-ID: <20051102161103.GA22389@lst.de>
References: <20051103002012.5e422ae5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103002012.5e422ae5.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 12:20:12AM +1100, Stephen Rothwell wrote:
> Because bash (on ppc64 at least) does a TIOCSTART ioctl when ^C is
> pressed.  The ioctl always returned EINVAL but now we also get the log
> message.  Should we put the COMPATIBLE_IOCTL bits back?

Hmm.  Checking my syslog I see these aswell.  I'd say put them back into
common code, with a big comment explaining this. Unless someone beats me
I'll hack up a patch today.

