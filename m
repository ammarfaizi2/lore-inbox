Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSAJIcu>; Thu, 10 Jan 2002 03:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSAJIcm>; Thu, 10 Jan 2002 03:32:42 -0500
Received: from mta02bw.bigpond.com ([139.134.6.34]:14543 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S287616AbSAJIc0>; Thu, 10 Jan 2002 03:32:26 -0500
Date: Thu, 10 Jan 2002 17:30:29 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>, viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-Id: <20020110173029.7616f752.rusty@rustcorp.com.au>
In-Reply-To: <a1grbm$n6o$1@cesium.transmeta.com>
In-Reply-To: <20020108192450.GA14734@kroah.com>
	<20020109045109.GA17776@kroah.com>
	<a1giqs$93d$1@cesium.transmeta.com>
	<20020109060951.GA18024@kroah.com>
	<a1grbm$n6o$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2002 23:26:46 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:
> *** Handling of hard links
> 
> When a nondirectory with c_nlink > 1 is seen, the (c_maj,c_min,c_ino)
> tuple is looked up in a tuple buffer.  If not found, it is entered in
> the tuple buffer and the entry is created as usual; if found, a hard
> link rather than a second copy of the file is created.  It is not

HPA,
	gnu cpio (v 2.4.2) actually puts the contents in the *last*
entry, for hardlinks in "newc" format.  This probably means you should
specify that if it's a found tuple, and c_filesize is non-zero,
overwrite the contents of the file.

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
