Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWBNEuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWBNEuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWBNEuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:50:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14340 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030340AbWBNEuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:50:35 -0500
Date: Tue, 14 Feb 2006 05:50:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Yoss <bartek@milc.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060214045022.GA10045@w.ods.org>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org> <43F12597.2000006@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F12597.2000006@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:34:31AM +0100, Roberto Nibali wrote:
> >>So there is missing about ~300MB.
> >>If anyone wants to have more detailed info feel free to ask.
> > 
> >You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
> >of memory used by dentry_cache and inode_cache and that's expected. This
> 
> Well, 300M dentry and inode is quite a lot for a system that has been up 
> at most for 6 days.

my notebood eats more than the double of this when doing its slocate
3 min after boot, so that depends on what it does ;-)

> >memory will be reclaimed when needed (for instance by calls to malloc()).
> 
> slabtop -s c -o | head -20
> 
> would be interesting to see, otherwise I agree with Willy, as always ;).

:-)

> Cheers,
> Roberto Nibali, ratz

cheers,
Willy

