Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTEBMvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTEBMvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:51:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61969 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262032AbTEBMvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:51:21 -0400
Date: Fri, 2 May 2003 15:03:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Backlund <tmb@iki.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Message-ID: <20030502130331.GA1803@alpha.home.local>
References: <3EB0413D.2050200@superonline.com> <200305011801.39014.tmb@iki.fi> <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk> <200305020314.01875.tmb@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305020314.01875.tmb@iki.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 03:14:01AM +0300, Thomas Backlund wrote:
> And here are the results...
[snip]

Hi Thomas,

With this patch, vesafb doesn't work anymore on my vaio notebook in 1400x1050
nor 1280x1024, because scree_info.lfb_size is reported to be 127, while it
should be 175 and 160 instead ! So I modified your patch a little bit to get it
right :

- video_size          = screen_info.lfb_size * screen_info.lfb_height * video_bpp;
+ video_size          = screen_info.lfb_width/8 * screen_info.lfb_height * video_bpp;

and it now works again.
Maybe I have a broken bios, but other people might have the problem too.

Cheers,
Willy
