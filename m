Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWEHH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWEHH5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWEHH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:57:12 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:2762 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751146AbWEHH5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:57:12 -0400
Message-ID: <445EF9F7.7080405@hozac.com>
Date: Mon, 08 May 2006 09:57:43 +0200
From: Daniel Hokka Zakrisson <daniel@hozac.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com> <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, I was actually really surprised that we'd ever allow a non-slab page 
> to be free'd as a slab or kmalloc allocation, without screaming very 
> loudly indeed. That implies a lack of some pretty fundamental sanity 
> checking by default in the slab layer (I suspect slab debugging turns it 
> on, but even without it, that's just nasty).
> 
> Can you see if this trivial patch at least causes a honking huge 
> "kernel BUG" message to be triggered quickly?

It doesn't, at least not before the machine becomes unresponsive.

-- 
Daniel Hokka Zakrisson
