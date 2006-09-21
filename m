Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWIUWqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWIUWqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIUWqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:46:50 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:45251 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932094AbWIUWqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:46:49 -0400
Date: Thu, 21 Sep 2006 15:34:53 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Dave Jones <davej@redhat.com>
cc: Sean <seanlkml@sympatico.ca>, Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <20060921224051.GS26683@redhat.com>
Message-ID: <Pine.LNX.4.63.0609211530180.17238@qynat.qvtvafvgr.pbz>
References: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE> 
 <20060921175717.272c58ee.seanlkml@sympatico.ca> 
 <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz> 
 <20060921222443.GO26683@redhat.com>  <Pine.LNX.4.63.0609211514470.17238@qynat.qvtvafvgr.pbz>
 <20060921224051.GS26683@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Dave Jones wrote:

> 
> On Thu, Sep 21, 2006 at 03:16:57PM -0700, David Lang wrote:
> > On Thu, 21 Sep 2006, Dave Jones wrote:
> >
> > > On Thu, Sep 21, 2006 at 03:00:48PM -0700, David Lang wrote:
> > >
> > > > for the tarball users they would have to grab
> > > > multiple patches to get from the last thing that they have to whatever is
> > > > current.
> > >
> > > ketchup solves that problem. One command brings any tree up to current.
> >
> > so are you saying that ketchup should be used for _all_ access to the vanilla
> > tree that isn't done via git?
> > if not then tarballs still have a place.
>
> I think you have a misunderstanding over what ketchup is/does.
> It cannot usurp tarballs by its very nature. It retrieves tarballs (if necessary)
> and whatever patches are necessary to get to the tree you want.
> http://www.selenic.com/ketchup/

in that case the compression of the tarballs is still worth dealing with

> > and how does ketchup deal with patched trees to start with?
>
> By unpatching if necessary.

assuming that it knows where to get the patches from, I was refering to things 
like the debian or redhat tree with their patches.

> > > > also people could be behind a firewall that prevents git from working properly,
> > > > for them tarballs and patches are the right way of doing things.
> > >
> > > If they can't git through a firewall, they won't be able to wget a tarball through
> > > it either.
> >
> > to work properly git should talk it's own protocol, http/ftp can be allowed (and
> > authenticated) through firewalls that don't allow the git protocol.
>
> 'properly' is the wrong word here. optimally, yes, but the firewall argument
> alone isn't sufficient to claim git can't be used to clone a tree.
> A tree cloned over http: vs one over git: has exactly the same information in
> it. All the history, all the changes. Everything.

in most cases, but there are cases where the dumb transports can make mistakes 
(there have been several threads on the git list covering these), git is good 
enough to notice mos of them, but there is still room for problems. Also, 
installing and configuring git should not be a prerequesite to getting the 
kernel.

the point being git and ketchup do not eliminate the need to transfer tarballs, 
and therfor do not eliminate the attractivness of a compression that saves a 
significant amount of bandwidth.

I was responding to the (apparent) argument that with git and ketchup people 
should not ever be downloading tarballs, so something that cuts the size of a 
tarball in half doesn't make any difference.

David Lang
