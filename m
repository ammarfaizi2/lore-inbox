Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTKXT0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTKXT0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:26:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:41104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263812AbTKXT0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:26:44 -0500
Date: Mon, 24 Nov 2003 11:27:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       Paul.McKenney@us.ibm.com
Subject: Re: [BUG]Missing i_sb NULL pointer check in destroy_inode()
Message-Id: <20031124112718.1e650478.akpm@osdl.org>
In-Reply-To: <1069700440.16649.19433.camel@localhost.localdomain>
References: <1068045518.10730.266.camel@socrates>
	<20031105181600.GC18278@thunk.org>
	<1068066524.10726.289.camel@socrates>
	<20031106033817.GB22081@thunk.org>
	<1068145132.10735.322.camel@socrates>
	<20031106123922.Y10197@schatzie.adilger.int>
	<1068148881.10730.337.camel@socrates>
	<1068230146.10726.359.camel@socrates>
	<20031109130826.2b37219d.akpm@osdl.org>
	<1068419747.687.28.camel@socrates>
	<20031109152936.3a9ffb69.akpm@osdl.org>
	<1069700440.16649.19433.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> destroy_inode() dereferences inode->i_sb without checking if it is NULL.
> This is inconsistent with its caller: iput() and clear_inode(),  both of
> which check inode->i_sb before dereferencing it.

I assume this has only been observed with an out-of-tree filesystem, but
yes, the consistency is good.

