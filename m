Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSIEQjU>; Thu, 5 Sep 2002 12:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSIEQjU>; Thu, 5 Sep 2002 12:39:20 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:2979 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S317799AbSIEQjT>;
	Thu, 5 Sep 2002 12:39:19 -0400
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <20020905181721.D32687@namesys.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny>
	<20020905054008.GH24323@louise.pinerecords.com>
	<20020904.223651.79770866.davem@redhat.com>
	<20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com>
	<1031234624.1726.224.camel@tiny>  <20020905181721.D32687@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Sep 2002 12:45:34 -0400
Message-Id: <1031244334.1684.264.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 10:17, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Sep 05, 2002 at 10:03:44AM -0400, Chris Mason wrote:
> 
> > read the -noleaf description on the find man page to see why we need to
> > set the directory link count to 1 when we are lying to userspace about
> > the actual link count on directories. 
> 
> There is nothing about nlink == 1 means assume -noleaf, so it should not work
> with old way too, right? Have anybody verified? ;)

I remember that happening during the initial discussions for the link
patch.  1 was chosen as the best way to do it, since it was a flag to
various programs that the unix directory link convention was not being
followed.

> 
> Actually patch might be easily modified to represent i_nlink == 1 for
> large directories, but still maintain correct on-disk nlink count.

Right.

> (and show maximal possible nlink count for regular files. Hm,
> I wonder if tar and stuff would break if met with file that have
> 67000 hardlinks ;) ).

Certainly seems like it would on sparc at least ;-)

-chris


