Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRMUf>; Mon, 18 Dec 2000 07:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQLRMUQ>; Mon, 18 Dec 2000 07:20:16 -0500
Received: from zeus.kernel.org ([209.10.41.242]:26117 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130791AbQLRMUI>;
	Mon, 18 Dec 2000 07:20:08 -0500
Date: Mon, 18 Dec 2000 11:46:12 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
Message-ID: <20001218114612.E21351@redhat.com>
In-Reply-To: <20001215105148.E11931@redhat.com> <Pine.LNX.4.21.0012170027060.28849-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0012170027060.28849-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sun, Dec 17, 2000 at 12:38:17AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 17, 2000 at 12:38:17AM -0200, Marcelo Tosatti wrote:
> On Fri, 15 Dec 2000, Stephen C. Tweedie wrote:
> 
> Stephen,
> 
> The ->flush() operation (which we've been discussing a bit) would be very
> useful now (mainly for XFS).
> 
> At page_launder(), we can call ->flush() if the given page has it defined.
> Otherwise use try_to_free_buffers() as we do now for filesystems which
> dont care about the special flushing treatment. 

As of 2.4.0test12, page_launder() will already call the
per-address-space writepage() operation for dirty pages.  Do you need
something similar for clean pages too, or does Linus's new laundry
code give you what you need now?

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
