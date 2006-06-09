Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWFIXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWFIXHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWFIXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:07:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932570AbWFIXHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:07:31 -0400
Date: Fri, 9 Jun 2006 16:06:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Dave Jones <davej@redhat.com>,
       Theodore Tso <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609225604.GK5964@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.64.0606091604390.5498@g5.osdl.org>
References: <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
 <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
 <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
 <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com>
 <20060609205036.GI7420@redhat.com> <4489E8EF.5020508@garzik.org>
 <20060609225604.GK5964@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Andreas Dilger wrote:
> 
> Umm, and how is this fundamentally different from similar code paths in
> the VFS (e.g. O_DIRECT vs regular writes)?

That's a great argument.

You're arguing that your thing is good by pointing to a known disaster 
area and saying "but that other thing does it too, so it must be good".

O_DIRECT is a piece of crap, and I'm still sorry that I didn't push back 
enough on it. And I _did_ push back on it. But I finally was worn down.

And yes, part of the problem is exactly that it uses _almost_ the same 
paths, but not quite. 

Oh, well.

		Linus
