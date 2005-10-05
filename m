Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVJEQlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVJEQlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVJEQlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:41:13 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:13985 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030234AbVJEQlM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:41:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJPYWE5sbqOjqmX61fPWOWfq6fVoUbfcO6T7UiFC2aodvneJvMbWhpnQJ9GQ+B7hhZtnALbBI141hHgZkf5aK9+fgv2uvtADuerwJ+B2j7cqYnAw1PMoQsBr+jBTCBBft7cK+8Bt4ytJ0pBQFAiy2Vn37NnJQaEgVOvHLKL1PFI=
Message-ID: <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
Date: Wed, 5 Oct 2005 09:41:10 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: what's next for the linux kernel?
Cc: Nix <nix@esperi.org.uk>, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510051744480.2279@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	 <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
	 <Pine.LNX.4.58.0510051744480.2279@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ss, is gone, so is the file.
>
> > Back on topic...
> >
> > The problem with private namespaces on Linux is that they really
> > aren't so much.  mount will update /etc/mtab for all to see and even
>
> Userspace problem.-)

Sure is, which is why I think it's easier to fork a BSD to make it do
what someone wants than to roll my own linux distribution :-).  
Perhaps that's a problem of perception and not a really good
measurement of the amount of energy involved in either alternative.

Sometimes it sure seems easier to keep the userspace stuff with the kernel.

> > I think private namespaces could actually be made more-so but the rest
> > of the system has to cooperate and I doubt that I have the energy to
> > do the evangelism and requisite proofs of concept for Linux.  It's far
> > easier for me to just use Plan 9 and Inferno instead of trying to
> > assimilate Linux, even though I think I'd prefer Linux if it were more
> > like the former two.
>
> The plan is:
>
> 1) make namespaces joinable
> 2) ???
> 3) profit
>
> No, that's wrong. The plan is (should be?):
>
> 1) make namespaces joinable in a sane way
> 2) wait for the shared subtree patch
> 3) make pam join the per-user-namespace
> 4) make pam automount tmpfs on the private /tmp

I'm not sure what you mean by a joinable namespace.  I also am not
sure I want them :-).

I think of namespaces as being fundamental to the process model and
that they are inherited from the parent and new ones are created in a
sort of COW fashion [or at least have similar behavior].

You might want a session namespace instead of a joinable per-process
namespace but I think that might be a slightly different point of
view.

Dave
