Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVJGHKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVJGHKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVJGHKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:10:38 -0400
Received: from colino.net ([213.41.131.56]:12017 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S1750704AbVJGHKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:10:37 -0400
Date: Fri, 7 Oct 2005 09:10:05 +0200
From: Colin Leroy <colin@colino.net>
To: Horms <horms@verge.net.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH] hfs, hfsplus: don't leak s_fs_info and fix an oops
In-Reply-To: <20051007043924.GA20827@verge.net.au>
References: <20051007043924.GA20827@verge.net.au>
X-Mailer: Sylpheed-Claws 1.9.15cvs18 (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20051007071008.CAC4E10334@paperstreet.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Oct 2005 at 13h10, Horms wrote:

Hi, 

> I took a look at making a backport, and it seems that
> some of the problems are there, but without a deeper inspection
> of the code its difficult to tell if the problems manifest or not.

That was easy to get the oops:

$ dd if=/dev/zero of=im_not_hfsplus count=10 #for example
$ mkdir test_dir
$ sudo mount -o loop -t hfsplus ./im_not_hfsplus ./testdir
$ dmesg

-- 
Colin
