Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTKXUIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTKXUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:08:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:15848 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263886AbTKXUID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:08:03 -0500
Subject: Re: [BUG]Missing i_sb NULL pointer check in destroy_inode()
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       Paul.McKenney@us.ibm.com
In-Reply-To: <20031124112718.1e650478.akpm@osdl.org>
References: <1068045518.10730.266.camel@socrates>
	<20031105181600.GC18278@thunk.org> <1068066524.10726.289.camel@socrates>
	<20031106033817.GB22081@thunk.org> <1068145132.10735.322.camel@socrates>
	<20031106123922.Y10197@schatzie.adilger.int>
	<1068148881.10730.337.camel@socrates> <1068230146.10726.359.camel@socrates>
	<20031109130826.2b37219d.akpm@osdl.org> <1068419747.687.28.camel@socrates>
	<20031109152936.3a9ffb69.akpm@osdl.org>
	<1069700440.16649.19433.camel@localhost.localdomain> 
	<20031124112718.1e650478.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Nov 2003 12:10:15 -0800
Message-Id: <1069704617.16649.19508.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 11:27, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > destroy_inode() dereferences inode->i_sb without checking if it is NULL.
> > This is inconsistent with its caller: iput() and clear_inode(),  both of
> > which check inode->i_sb before dereferencing it.
> 
> I assume this has only been observed with an out-of-tree filesystem, but
> yes, the consistency is good.
> 

Yes,  the crash happened with an out-of-tree filesystem.  Thanks.

-Mingming


