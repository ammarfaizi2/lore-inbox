Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUIHDE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUIHDE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUIHDE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:04:27 -0400
Received: from holomorphy.com ([207.189.100.168]:22436 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269010AbUIHDEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:04:25 -0400
Date: Tue, 7 Sep 2004 20:03:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908030342.GW3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hans Reiser <reiser@namesys.com>,
	David Masover <ninja@slaphack.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
	Tonnerre <tonnerre@thundrix.ch>,
	Christer Weinigel <christer@weinigel.se>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com> <413D4ED9.5090206@namesys.com> <20040907062806.GL3106@holomorphy.com> <20040907223801.GS3106@holomorphy.com> <20040908024319.GU3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908024319.GU3106@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 07:43:19PM -0700, William Lee Irwin III wrote:
> -	return (count_t)(max_off / device->blksize);
> +	return (size & ~4096ULL)/device->blksize;

Correcting this to return (size & ~4095ULL)/device->blksize does not
fix the coredumps.


-- wli
