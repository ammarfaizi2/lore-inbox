Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVCAWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVCAWUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVCAWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:20:21 -0500
Received: from colin2.muc.de ([193.149.48.15]:3588 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262097AbVCAWTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:19:03 -0500
Date: 1 Mar 2005 23:19:02 +0100
Date: Tue, 1 Mar 2005 23:19:02 +0100
From: Andi Kleen <ak@muc.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Bernd Schubert <bernd-schubert@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050301221902.GA73844@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <20050301202417.GA40466@muc.de> <200503012207.02915.bernd-schubert@web.de> <jewtsruie9.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jewtsruie9.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:10:38PM +0100, Andreas Schwab wrote:
> That's because there are some values in the stat64 buffer delivered by the
> kernel which cannot be packed into the stat buffer that you pass to stat.
> Use stat64 or _FILE_OFFSET_BITS=64.

If that had been the case strace would have reported EOVERFLOW
or E2BIG. But it returned 0 according to the log that was posted.

-Andi
