Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDQNCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDQNCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDQNCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:02:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750768AbWDQNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:02:02 -0400
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap
	to exceed 2G
From: Arjan van de Ven <arjan@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: sho@tnes.nec.co.jp, Ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060413162028.GA23452@thunk.org>
References: <20060413161227sho@rifu.tnes.nec.co.jp>
	 <20060413162028.GA23452@thunk.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:01:53 +0200
Message-Id: <1145278913.2847.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 12:20 -0400, Theodore Ts'o wrote:
> On Thu, Apr 13, 2006 at 04:12:27PM +0900, sho@tnes.nec.co.jp wrote:
> > Summary of this patch:
> >   [15/21] change the type of variables which manipulate bitmap
> >           - Change the type of 4byte variables manipulating bitmap
> >             from signed to unsigned.
> 
> Generalized NACK.  We can't just blindly change function signatures of
> pre-existing functions in libext2fs, since this breaks the ABI with
> pre-existing applications linked with current shared libraries of
> libext2fs.
> 
> We could bump the major version number, but what I'd much rather do is
> to create new functions which use the 64-bit blk64_t (i.e.,
> ext2fs_mark_block_bitmap2).  This will make the patches much bigger,
> but it allows us to preserve backwards compatibility.

would this be a time to consider using ELF function versioning (similar
to what glibc and others use for abi comat) in libext2fs ?

