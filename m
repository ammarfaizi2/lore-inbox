Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEPEzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEPEzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUEPEzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:55:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbUEPEzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:55:40 -0400
Date: Sun, 16 May 2004 05:55:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Pascal Schmidt <der.eremit@email.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS & long symlinks = stack overflow
Message-ID: <20040516045538.GR17014@parcelfarce.linux.theplanet.co.uk>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it> <E1BP0BI-0000lo-09@localhost> <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk> <1084642637.3490.29.camel@lade.trondhjem.org> <Pine.LNX.4.58.0405152136380.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405152136380.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 09:41:12PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 15 May 2004, Trond Myklebust wrote:
> > 
> > Yes. The following patch (backported from the NFSv4 code) should do the
> > right thing...
> 
> Why isn't this needed for nfsv2, which has similar code? 

v2 has a hard limit in protocol (<= 1Kb).  However, we shouldn't assume that
server is sane...
