Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUEOOxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUEOOxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUEOOxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:53:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261779AbUEOOxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:53:06 -0400
Date: Sat, 15 May 2004 15:53:06 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS & long symlinks = stack overflow
Message-ID: <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it> <E1BP0BI-0000lo-09@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BP0BI-0000lo-09@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 04:30:28PM +0200, Pascal Schmidt wrote:
> On Sat, 15 May 2004 16:00:21 +0200, you wrote in linux.kernel:
> 
> > Lovely.  The real limit imposed by client (apparently not enforced, though)
> > is PAGE_CACHE_SIZE - 4 - 1.  What are the protocol limits?
> 
> None. An NFSv3 server can enforce an arbitrary limit on filename length,
> advertised via PATHCONF, though.

Lovely...  How are other clients dealing with that?  Put a reasonable
limit on the size and return an error if READLINK brings more than that?
