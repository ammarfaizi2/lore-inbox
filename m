Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSIERVO>; Thu, 5 Sep 2002 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSIERVO>; Thu, 5 Sep 2002 13:21:14 -0400
Received: from angband.namesys.com ([212.16.7.85]:39852 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315870AbSIERVO>; Thu, 5 Sep 2002 13:21:14 -0400
Date: Thu, 5 Sep 2002 21:25:45 +0400
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905212545.A5349@namesys.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1031244334.1684.264.camel@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 05, 2002 at 12:45:34PM -0400, Chris Mason wrote:
> > > read the -noleaf description on the find man page to see why we need to
> > > set the directory link count to 1 when we are lying to userspace about
> > > the actual link count on directories. 
> > 
> > There is nothing about nlink == 1 means assume -noleaf, so it should not work
> > with old way too, right? Have anybody verified? ;)
> I remember that happening during the initial discussions for the link
> patch.  1 was chosen as the best way to do it, since it was a flag to
> various programs that the unix directory link convention was not being
> followed.
> > Actually patch might be easily modified to represent i_nlink == 1 for
> > large directories, but still maintain correct on-disk nlink count.
> Right.

Ok, I will come up with revised patch tomorrow and do 2.5 port (and
advise Vitaly about reiserfsck part)

Bye,
    Oleg
