Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289101AbSAGDWc>; Sun, 6 Jan 2002 22:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSAGDWW>; Sun, 6 Jan 2002 22:22:22 -0500
Received: from are.twiddle.net ([64.81.246.98]:45184 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S289101AbSAGDWJ>;
	Sun, 6 Jan 2002 22:22:09 -0500
Date: Sun, 6 Jan 2002 19:22:04 -0800
From: Richard Henderson <rth@twiddle.net>
To: Anton Blanchard <anton@samba.org>
Cc: Dave Jones <davej@suse.de>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: results: Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106192204.B27356@twiddle.net>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Dave Jones <davej@suse.de>, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020106.060824.106263786.davem@redhat.com> <Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de> <20020107012555.GA6623@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107012555.GA6623@krispykreme>; from anton@samba.org on Mon, Jan 07, 2002 at 12:25:55PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 12:25:55PM +1100, Anton Blanchard wrote:
>         li 11,120		; sizeof(struct page)
[...]
>         divd 0,0,11
> 
> Perhaps the compiler should be optimising this better (can we replace
> the divide?)

The powerpc backend claims to have a fast divide instruction
(via RTX_COST if you care about such things).  We'll replace
with shift when dividing by powers of 2, but won't try the
multiply by a constant inverse trick.


r~
