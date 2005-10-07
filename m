Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVJGHeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVJGHeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJGHeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:34:15 -0400
Received: from koto.vergenet.net ([210.128.90.7]:3242 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750960AbVJGHeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:34:14 -0400
Date: Fri, 7 Oct 2005 16:31:02 +0900
From: Horms <horms@debian.org>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: [PATCH] hfs, hfsplus: don't leak s_fs_info and fix an oops
Message-ID: <20051007073102.GB6026@verge.net.au>
Mail-Followup-To: Colin Leroy <colin@colino.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <20051007043924.GA20827@verge.net.au> <20051007071008.CAC4E10334@paperstreet.colino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007071008.CAC4E10334@paperstreet.colino.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 09:10:05AM +0200, Colin Leroy wrote:
> On 07 Oct 2005 at 13h10, Horms wrote:
> 
> Hi, 
> 
> > I took a look at making a backport, and it seems that
> > some of the problems are there, but without a deeper inspection
> > of the code its difficult to tell if the problems manifest or not.
> 
> That was easy to get the oops:
> 
> $ dd if=/dev/zero of=im_not_hfsplus count=10 #for example
> $ mkdir test_dir
> $ sudo mount -o loop -t hfsplus ./im_not_hfsplus ./testdir
> $ dmesg

Silly me, I should have thought of that :-)

-- 
Horms
