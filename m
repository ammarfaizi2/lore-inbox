Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbTCCWur>; Mon, 3 Mar 2003 17:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268846AbTCCWur>; Mon, 3 Mar 2003 17:50:47 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:46076 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S268842AbTCCWup>; Mon, 3 Mar 2003 17:50:45 -0500
Date: Mon, 3 Mar 2003 18:01:12 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030303180112.D6915@redhat.com>
References: <Pine.LNX.4.44.0303031108390.12011-100000@home.transmeta.com> <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 03, 2003 at 11:58:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:58:27PM +0000, Alan Cox wrote:
> On Mon, 2003-03-03 at 19:13, Linus Torvalds wrote:
> > dentry itself. Yes, you could make it smaller (you could remove the inline
> > string from it, for example, and you could avoid allocating it at
> 
> How about at least making the inline string align to the slab alignment so we
> dont waste space ?

Also, making the qstr length an unsigned short or u8 would increase the 
length of the string by 2 or 3 bytes quite for free.

		-ben
-- 
Junk email?  <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
