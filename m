Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274235AbRISWgJ>; Wed, 19 Sep 2001 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272282AbRISWgA>; Wed, 19 Sep 2001 18:36:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44886 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274235AbRISWfo>; Wed, 19 Sep 2001 18:35:44 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillips@bonn-fries.net (Daniel Phillips),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <E15jpRy-0003yt-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 16:26:40 -0600
In-Reply-To: <E15jpRy-0003yt-00@the-village.bc.nu>
Message-ID: <m166aeg6lb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Much of this goes away if you get rid of both the swap and anonymous page
> special cases. Back anonymous pages with the "whoops everything I write here
> vanishes mysteriously" file system and swap with a swapfs

Essentially.  Though that is just the strategy it doesn't cut to the heart of the
problems that need to be addressed.  The trickiest part is to allocate persistent
id's to the pages that don't require us to fragment the VMA's.  

> Reverse mappings make linear aging easier to do but are not critical (we
> can walk all physical pages via the page map array). 

Agreed.  

What I find interesting about the 2.4.x VM is that most of the large
problems people have seen were not stupid designs mistakes in the VM
but small interaction glitches, between various pieces of code.

Eric
