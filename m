Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRLIQEY>; Sun, 9 Dec 2001 11:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283573AbRLIQEN>; Sun, 9 Dec 2001 11:04:13 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:35523
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S283571AbRLIQED>; Sun, 9 Dec 2001 11:04:03 -0500
Date: Sun, 09 Dec 2001 10:59:45 -0500
From: Chris Mason <mason@suse.com>
To: Russell Coker <russell@coker.com.au>, reiserfs-list@namesys.com
cc: linux-kernel@vger.kernel.org
Subject: Re: per-char IO tests
Message-ID: <1764650000.1007913585@tiny>
In-Reply-To: <20011209151431.2172397E@lyta.coker.com.au>
In-Reply-To: <20011209151431.2172397E@lyta.coker.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, December 09, 2001 04:14:30 PM +0100 Russell Coker
<russell@coker.com.au> wrote:

> Both machines run ReiserFS.  A quick test indicates that using Ext2 instead 
> of ReiserFS triples the  performance of write(fd, buf, 1), but this is 
> something I already knew (and had mentioned before on the ReiserFS list).

This is most likely from logging the inode as you extend the file.  Recent
pre releases for 2.4.17 include a from patch from Andrew that should help,
but I expect reiserfs to still be somewhat slower.

-chris
