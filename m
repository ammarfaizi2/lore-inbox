Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUIASCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUIASCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIASCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:02:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:9927 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266910AbUIASC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:02:27 -0400
Date: Wed, 1 Sep 2004 11:02:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901110225.D1973@build.pdx.osdl.net>
References: <20040901072245.GF13749@mellanox.co.il> <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk> <52zn4a0ysg.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52zn4a0ysg.fsf@topspin.com>; from roland@topspin.com on Wed, Sep 01, 2004 at 08:55:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland Dreier (roland@topspin.com) wrote:
>  - read/write on char device:
>      OK, except requires some mechanism (tag #) for matching requests
>      and responses.  Nowhere clean to put 32/64 compatibility code.

You forgot a driver specific filesystem which exposes requests in a file
per request type style.  Also, there's a simple_transaction type of file
which can allow you send/recv data and should eliminate the need for
tagging.  Example, look at nfsd fs (fs/nfsd/nfsctl.c).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
