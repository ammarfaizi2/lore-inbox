Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUF3UXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUF3UXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUF3UW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:22:28 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:7913 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S262329AbUF3UUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:20:13 -0400
Date: Wed, 30 Jun 2004 16:20:03 -0400 (EDT)
From: John Heffner <jheffner@psc.edu>
To: "David S. Miller" <davem@redhat.com>
cc: Debi Janos <debi.janos@freemail.hu>, <linux-kernel@vger.kernel.org>,
       <shemminger@osdl.org>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
In-Reply-To: <20040630131437.20b5b80a.davem@redhat.com>
Message-ID: <Pine.NEB.4.33.0406301616270.21171-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004, David S. Miller wrote:

> On Wed, 30 Jun 2004 10:04:52 +0200
> Debi Janos <debi.janos@freemail.hu> wrote:
>
> > 2004-06-29, k keltezéssel 23:36-kor John Heffner ezt írta:
> >
> > > Sigh.  I ran in to this problem a year or so ago and it was a broken
> > > firewall that was mangling the TCP window scale option.  I think the
> > > firewall was an OpenBSD machine, and I was told the problem went away with
> > > an upgrade.  I'm curious what they're running here.
> > >
> > > The boundary 3 is special because it causes SWS avoidance to break.
> > >
> > >   -John
> >
> > hmm. interesting. my server sits behind an openbsd packet filter... , but the gentoo's machines uses iptables firewall...
>
> Sounds like the firewall at your end is what might be causing the
> problems.


I'm having the same problem connecting to gentoo's machines with no
firewall on my end.  This happens with new kernels with the
default_win_scale set >3, or on old kernels with tcp_rmem[1] > ~700k.

  -John

