Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbREFBxq>; Sat, 5 May 2001 21:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbREFBxh>; Sat, 5 May 2001 21:53:37 -0400
Received: from [203.167.188.69] ([203.167.188.69]:20422 "HELO tapu")
	by vger.kernel.org with SMTP id <S130485AbREFBx2>;
	Sat, 5 May 2001 21:53:28 -0400
Date: Sun, 6 May 2001 13:53:22 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Mitch Adair <mitch@theneteffect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010506135322.B11201@tapu.f00f.org>
In-Reply-To: <20010506033746.A30690@metastasis.f00f.org> <200105051634.LAA02026@mako.theneteffect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200105051634.LAA02026@mako.theneteffect.com>; from mitch@theneteffect.com on Sat, May 05, 2001 at 11:34:16AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 11:34:16AM -0500, Mitch Adair wrote:

    Wouldn't that be lot of the same issues as a "swapoff" with some
    portion of that in use?  (except for the kernel data case of
    course...)

No. Swapoff makes pages allocated to userland applications in swap
move back into main memory -- this is much easier because:

   - the pages are on disk, we _know_ the aren't locked my mlock or
     pinned for IO (kiobufs, whatever)

   - there are no kernel pages/buffers in this area, even harder than
     the above to deal with



  --cw

