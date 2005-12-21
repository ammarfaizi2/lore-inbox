Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVLUXOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVLUXOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVLUXOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:14:20 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:62918 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964938AbVLUXOS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:14:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HgYHbjmv5A61mr4Ab3lXgvsxBZGv26D7pBdXym9fAFr9ryIpYWN1VXpe4tmToASiLAV2uQvcBVsArHww5+4zx6ZF3/B/eK7KZK4sLm7FKDq7Q3M6AXpj7+3BVD81xLueg5xGNA0cAM22onnB8yQhcD6erLbmgf/5g+GgOvhWVrc=
Message-ID: <9a8748490512211514g62bec66dqfb00b4dc1aeb7628@mail.gmail.com>
Date: Thu, 22 Dec 2005 00:14:18 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051214234016.0112a86e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Andrew Morton <akpm@osdl.org> wrote:
>
<!-- snip -->
>
> -mm-implement-swap-prefetching.patch
> -mm-implement-swap-prefetching-default-y.patch
> -mm-implement-swap-prefetching-tweaks.patch
> -mm-implement-swap-prefetching-tweaks-2.patch
> -mm-swap-prefetch-magnify.patch
>
>  Dropped swap prefetching, sorry.  I wasn't able to notice much benefit from
>  it in my testing, and the number of mm/ patches in getting crazy, so we don't
>  have capacity for speculative things at present.
>
<!-- snip -->

This is a bit sad.
On my system (1.4GHz Athlon w/512MB RAM, 768MB swap) this did have an effect.
One situation in particular where it helped (and which is a common
case for me) was when I had OpenOffice2 + Eclipse (with CDT) + xchat +
nedit + Firefox + a few konsole windows open (running KDE 3.5 btw and
all apps usually have a lot of content loaded), minimized all the apps
and then started an allyesconfig build in one window - the
allyesconfig build would drag the machine to its knees and eat up more
or less all RAM + swap, so I usually left it alone for a while to
finish and when I then came back later and reactivated the apps I had
minimized they came back pretty fast. Without the swap prefetch
patches things come back somewhat slower - it's not an earth
shattering difference, but it's definately noticable.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
