Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269335AbUJKXq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269335AbUJKXq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUJKXq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:46:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:37096 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269335AbUJKXq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:46:26 -0400
Date: Tue, 12 Oct 2004 01:46:25 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
Message-ID: <20041011234625.GA17340@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com> <20041011214304.GD31731@wotan.suse.de> <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com> <20041011221519.GA11702@wotan.suse.de> <20041011153830.495b7c2d.akpm@osdl.org> <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 04:10:12PM -0700, Badari Pulavarty wrote:
> On Mon, 2004-10-11 at 15:38, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > > Console: colour VGA+ 80x25
> > > > Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> > > > Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > > > Bad page state at free_hot_cold_page (in process 'swapper', page
> > > > 000001017ac06070)
> > > > flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0
> > > 
> > > Some memory corruption or confused memory allocator.
> > 
> > I'd be suspecting no-buddy-bitmap-patch-*.patch
> > 
> 
> Nope. This is not it..
> 
> Andi, do you know which is the last good -mm kernel on AMD ?
> Is it 2.6.9-rc3-mm3 ? The last I tested on AMD was 2.6.9-rc2-mm3 :(

rc3-mm3/4 should work when you revert the optimize-profi... patch or boot
with profile=2 - i normally don't test -mm* myself, but some users
reported that.

But I'm not sure anybody tested it on a 4way. 

-Andi
