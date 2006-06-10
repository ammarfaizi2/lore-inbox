Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWFJBJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWFJBJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbWFJBJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:09:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16812 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030428AbWFJBJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:09:26 -0400
Message-ID: <448A1BBA.1030103@garzik.org>
Date: Fri, 09 Jun 2006 21:09:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org>
In-Reply-To: <20060610004727.GC7749@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> Jeff, you seem to think that the fact that the layout isn't precisely
> the same after an on-line resizing is proof of something horrible, but
> it isn't.  The exact location of filesystem metadata has never been
> fixed, not in the past ten years of ext2/3 history, and this is not a
> big deal.  It certainly isn't "proof" of on-line resizing being
> something horrible, as you keep trying to claim, without any arguments
> other than, "The layout is different!".  

No, I was proving merely that it is _different_.  And the values where 
you see a _difference_ are the ones of which are no longer sized 
optimally, after you grow the fs to a larger size.

So you incur a performance penalty for resizing to size S2, rather than 
mke2fs'ing the new blkdev at size S2.  Certainly within the confines of 
ext3 that cannot be helped, but a different inode allocation strategy 
could improve upon that.

	Jeff


