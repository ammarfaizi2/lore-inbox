Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291273AbSBGUV6>; Thu, 7 Feb 2002 15:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291271AbSBGUVp>; Thu, 7 Feb 2002 15:21:45 -0500
Received: from air-2.osdl.org ([65.201.151.6]:12725 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291267AbSBGUVj>;
	Thu, 7 Feb 2002 15:21:39 -0500
Date: Thu, 7 Feb 2002 12:21:41 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <1126CC346B32@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0202071220040.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Petr Vandrovec wrote:

> On  7 Feb 02 at 10:27, Patrick Mochel wrote:
> 
> > Concerning reading/writing from offsets, it's up to the drivers for them 
> > to either support it or not. In the files I've done so far, I return 0 if 
> > show() is called with an offset. Which will give different results if you 
> > read byte-by-byte or an entire chunk. 
> > 
> > It makes the callbacks simpler, but it is not technically correct. 
> 
> What about extremelly nice stuff Al Viro made for us in
> fs/seq_file.c ? It made putting stuff into procfs really easy...

It is really nice, but it's too much for the common case. The goal is to 
have each file export one and only one value. Setting up an iterator is 
overkill for one value.

	-pat

