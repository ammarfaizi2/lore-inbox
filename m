Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUGJTlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUGJTlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUGJTlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:41:12 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:13696 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266358AbUGJTlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:41:03 -0400
Date: Sat, 10 Jul 2004 12:40:53 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040710194053.GA5809@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <je658vwtbl.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je658vwtbl.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 09:33:34PM +0200, Andreas Schwab wrote:

> Security.  You don't want old contents of /etc/shadow appear in
> random files after a crash.

If we had a different log format we could determine if the blocks were
newly allocated and avoid zeroing that for existing files, we could
even do the code to aggregate transactions which would be *really*
nice for some things.  Lots of work though.


  --cw
