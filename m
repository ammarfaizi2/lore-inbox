Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFTJfH>; Thu, 20 Jun 2002 05:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSFTJfH>; Thu, 20 Jun 2002 05:35:07 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:50048 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313060AbSFTJfG>; Thu, 20 Jun 2002 05:35:06 -0400
Date: Thu, 20 Jun 2002 10:34:29 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christopher Li <chrisl@gnuchina.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020620103429.A2464@redhat.com>
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <E17KoGz-0000y5-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17KoGz-0000y5-00@starship>; from phillips@bonn-fries.net on Thu, Jun 20, 2002 at 12:49:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2002 at 12:49:57AM +0200, Daniel Phillips wrote:
 
> I don't have code, but let me remind you of this post:
> 
>    http://marc.theaimsgroup.com/?l=ext2-devel&m=102132142032096&w=2
> 
> A sketch of the coalescing design is at the end.  I'll formalize that.

One question --- just how stable will this be if we boot into a kernel
that doesn't have the coalescing enabled, and start modifying
directories?  We _could_ just teach the current code to clear those
top 8 bits in the parent any time we touch a leaf node, but that's
unnecessarily expensive, so we'd really need to have some way of
either recreating the hint fields from scratch every so often, or of
spotting when they have become badly out-of-date.

Cheers,
 Stephen
