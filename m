Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269953AbRHENSg>; Sun, 5 Aug 2001 09:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269955AbRHENSQ>; Sun, 5 Aug 2001 09:18:16 -0400
Received: from weta.f00f.org ([203.167.249.89]:41104 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269953AbRHENSG>;
	Sun, 5 Aug 2001 09:18:06 -0400
Date: Mon, 6 Aug 2001 01:18:59 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010806011859.A21830@weta.f00f.org>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <E15TNbk-0007pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15TNbk-0007pu-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 02:06:16PM +0100, Alan Cox wrote:

    Linus took itout because it was quite complex and nobody seemed to
    have cases that triggered it or made it useful

Hmm... well it seems the are cases which trigger this, mozilla and
vmware being quite common.

Is a less heavy-handed approach than the original code possible?
Something like when inserting into a processes vma, if there are more
than <n> entries, we lock/scan/coalesce/unlock --- or would this
locking be too gross?



  --cw
