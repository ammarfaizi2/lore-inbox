Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWBVUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWBVUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWBVUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:48:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751429AbWBVUs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:48:27 -0500
Date: Wed, 22 Feb 2006 12:44:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joel.Becker@oracle.com, gombasg@sztaki.hu, tytso@mit.edu,
       kay.sievers@suse.de, penberg@cs.helsinki.fi, gregkh@suse.de,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060222124428.4808b12e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602221205040.30245@g5.osdl.org>
References: <20060221225718.GA12480@vrfy.org>
	<20060221153305.5d0b123f.akpm@osdl.org>
	<20060222000429.GB12480@vrfy.org>
	<20060221162104.6b8c35b1.akpm@osdl.org>
	<Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	<Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	<20060222112158.GB26268@thunk.org>
	<20060222154820.GJ16648@ca-server1.us.oracle.com>
	<20060222162533.GA30316@thunk.org>
	<20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	<20060222185923.GL16648@ca-server1.us.oracle.com>
	<20060222115410.1394ff82.akpm@osdl.org>
	<Pine.LNX.4.64.0602221205040.30245@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> For example, say that you have more than just a couple of disks attached 
>  to the system, but many of them are for non-critical stuff. You do not 
>  necessarily want to wait for them all to spin up at all. You usually only 
>  care about one of them - the root device.

Well yes, but I was suggesting that userspace be given the option - run
insmod asynchronously if it's a problem.

It all does indicate that our single module_init(no args) interface is too
coarse...
