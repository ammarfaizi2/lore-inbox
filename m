Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSKBXE6>; Sat, 2 Nov 2002 18:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSKBXE6>; Sat, 2 Nov 2002 18:04:58 -0500
Received: from tapu.f00f.org ([66.60.186.129]:33413 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261498AbSKBXE5>;
	Sat, 2 Nov 2002 18:04:57 -0500
Date: Sat, 2 Nov 2002 15:11:28 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021102231128.GB7854@tapu.f00f.org>
References: <20021102070607.GB16100@think.thunk.org> <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 10:47:07AM -0800, Linus Torvalds wrote:

> - Make a new file type, and put just that information in the
>   directory (so that it shows up in d_type on a readdir()).  Put the
>   real data in the file, ie make it largely look like an "extended
>   symlink".

reading directories therefore causes lots of seeks and performance
begins to suck again

IMO, extended attributes are a better place to store this and making
it per-inode, there is an argument that having a file behave
differently in different places is unecessaryly complex and really
doesn't solve any know real-world problems



  --cw
