Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVITXHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVITXHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVITXHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:07:23 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:54547 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750766AbVITXHW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:07:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eD7Jgxba7tTODq1CeN+EvMkbWnz19Y3IJ3Zu+UFqGq6rMdC6bRxaeeicb4O09QKhzCOWeG9IOphoTVIpH5ToCq+shCQSN2ZMP+0/urGWFq5HQT8YigQf/RsLPChV54RB2EZ/baAc8EYXJgZHphC+MlcoGDPHdL1GHP8WbOhQ0Rk=
Message-ID: <9a8748490509201607859de65@mail.gmail.com>
Date: Wed, 21 Sep 2005 01:07:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Hot-patching
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <433093F5.4060808@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43308815.1000200@comcast.net>
	 <9a87484905092015471c2dc329@mail.gmail.com>
	 <433093F5.4060808@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, John Richard Moser <nigelenki@comcast.net> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jesper Juhl wrote:
> > On 9/21/05, John Richard Moser <nigelenki@comcast.net> wrote:
> > [snip]
> >
> >>Besides getting rid of a pet peeve of mine (more rebooting than
> >>absolutely necessary) and giving a way to continuously increase the size
> >>of the running kernel with each bugfix, this has implications on servers
> >>that don't want to reboot for whatever reason.  For enterprise
> >>applications, it would be possible to fix a kernel bug or security hole
> >>that hasn't been triggered by loading a module with the bugfixes,
> >>effectively hot-patching the kernel.
> >>
> >
> > [snip]
> >
> > If you have uptime demands like that I think a much better approach
> > would be to make sure the box is heavily firewalled so importance of
> > the security of the host itself drops. If there's no way to get to a
> > box in a way that enables you to actually exploit a security hole,
> > then it doesn't matter much that the hole is there at all.
> 
> Yeah.  Not always feasible though; let's say the bug manifests in
> something Apache tells the kernel to do (there's quite a lot of
> syscalls) based on stuff passed to CGI scripts.  Firewalls and
> everything, but slide in a "legitimate" port 80 or port 443 access and BLAM.
> 
> Shell servers like compile farms are also interesting, if you want to
> talk about firewalling not being all that great.  That's of course if
> you care about local attacks; personally if I have 10000 employees or
> clients using a machine I don't want to trust them all to be nice.
> 

Firewalls are not a panacea, no. But for many (not all) issues, good
firewalling can eliminate the immediate need to patch a server.

> >
> > Another option would be a clustered setup where you normally run the
> > app(s) on nodeA, nodeB ... nodeN, then when you need to upgrade you
> > move all running applications off of nodeA and upgrade it, move
> > everything off of nodeB and then upgrade that, repeat for nr of nodes,
> > finally redistribute the load properly again.
> >
> 
> Beautiful setup that, and surprisingly cost effective if 1) you can do
> it yourself, and 2) you're using just 2 nodes.  I'd prefer 3 nodes for a
> minimal set-up of course, so if I upgrade one and the other goes down I
> still have a third; I'm obsessive about perfectly stable environments,
> it has to be able to stand up to a bomb blast or the ending scene from
> Hackers with all the blackhats in the world tearing ass at the system.
> 

A few links you may want to take a look at : 

http://www.linuxvirtualserver.org/
http://www.linux-ha.org/
http://lcic.org/ha.html
http://openmosix.sourceforge.net/


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
