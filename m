Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLOQqP>; Fri, 15 Dec 2000 11:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLOQqF>; Fri, 15 Dec 2000 11:46:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:56846 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129387AbQLOQpx>;
	Fri, 15 Dec 2000 11:45:53 -0500
Date: Fri, 15 Dec 2000 16:13:23 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@muc.de>, wtenhave@sybase.com, hdeller@redhat.com,
        Eric Lowe <elowe@myrile.madriver.k12.oh.us>,
        Larry Woodman <woodman@missioncriticallinux.com>, linux-mm@kvack.org
Subject: Re: New patches for 2.2.18pre24 raw IO (fix for bounce buffer copy)
Message-ID: <20001215161323.P11931@redhat.com>
In-Reply-To: <20001204205004.H8700@redhat.com> <20001208130633.A31920@inspiron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001208130633.A31920@inspiron.random>; from andrea@suse.de on Fri, Dec 08, 2000 at 01:06:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 08, 2000 at 01:06:33PM +0100, Andrea Arcangeli wrote:
> On Mon, Dec 04, 2000 at 08:50:04PM +0000, Stephen C. Tweedie wrote:
> > I have pushed another set of raw IO patches out, this time to fix a
> This fix is missing:
> 
> --- rawio-sct/mm/memory.c.~1~	Fri Dec  8 03:05:01 2000
> +++ rawio-sct/mm/memory.c	Fri Dec  8 03:57:48 2000
> @@ -455,7 +455,7 @@
> -	struct vm_area_struct *	vma = 0;
> +	struct vm_area_struct *	vma;
> @@ -478,6 +478,7 @@
>   repeat:
> +	vma = NULL;
>  	down(&mm->mmap_sem);

Applied, I'm pushing out a 2.2.18 set of diffs now.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
