Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVHMVPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVHMVPE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVHMVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 17:15:04 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:50774 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932291AbVHMVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 17:15:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=mz5S5gnmobN6AsB7hD1BY0Zb7QtNVQ9dLkrKvzamqyCyzY82bm7XMxo3dTDo2C6ljMtwf4DcSJ+HJ7bQwIM112XtghHCU1iHQx9ZeEhuj5hviwNzgNX/wz7kPbXzPx3Cz7YHk6OqZ00PRriaxxYNuNO03JraSNIhGlIKkjy+svs=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.6.7+(or eariler)] Switching from LCD to external video w/ no external video connected causes deadlock - Regression
Date: Sat, 13 Aug 2005 17:13:27 -0400
User-Agent: KMail/1.8.1
References: <000201c47516$2dd74730$0200080a@panic> <20041110160407.6275b5be.akpm@osdl.org> <200411101914.59821.shawn.starr@rogers.com>
In-Reply-To: <200411101914.59821.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508131713.27418.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're back to square one, in VT mode the system deadlocks once again when 
switching between LCD, External video modes.

Kernel: 2.6.13-rc5 (merucurial build August 2nd snapshot).

Looks like this bug needs to be reopened again :/

Shawn.

On November 10, 2004 19:14, Shawn Starr wrote:
> As of 2.6.9 in Linux console, it properly switches between modes, there is
> a small delay when switching to external VGA (if you have sound playing it
> will repeat for a moment then resume).  There is no deadlocks.
>
> I cant test inside X just yet (w/ Xinerama extension)
>
> Shawn.
>
> On November 10, 2004 19:04, Andrew Morton wrote:
> > Is this still happening in current kernels?
> >
> > Thanks.
> >
> > "Shawn Starr" <shawn.starr@rogers.com> wrote:
> > > I've noticed a few people with IBM Thinkpads running 2.6.7+ - different
> > > models - have this problem. I don't know where in 2.6 this begin
> > > happening though.
> > >
> > > When you use the function key and switch from LCD to External Video,
> > > the system deadlocks.
> > > While ssh'd into the laptop the system has deadlocked once I switched
> > > video. Unfortunately, I don't have a USB <-> Serial dongle handy yet
> > > ;-)
> > >
> > > The Video card is a ATI Radeon 9600 64MB RAM, kernel has no framebuffer
> > > support enabled.
> > >
> > > Is this a known issue?
> > >
> > > Thanks.
> > >
> > > Shawn.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
