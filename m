Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSJLLGA>; Sat, 12 Oct 2002 07:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSJLLGA>; Sat, 12 Oct 2002 07:06:00 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:29715 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262882AbSJLLF7>; Sat, 12 Oct 2002 07:05:59 -0400
Date: Sat, 12 Oct 2002 04:11:40 -0700
From: jw schultz <jw@pegasys.ws>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
Message-ID: <20021012111140.GA22536@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com> <20021012095026.GC28537@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012095026.GC28537@merlin.emma.line.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 11:50:26AM +0200, Matthias Andree wrote:
> On Fri, 11 Oct 2002, Linus Torvalds wrote:
> 
> > PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> > stand.  I'm not using any kind of volume management personally, so I just
> > don't have the background or inclination to walk through the patches and
> > make that kind of decision. My non-scientific opinion is that it looks 
> > like the EVMS code is going to be merged, but ..
>
> A user's input, of not nearly as much weight as of the input you
> suggested, and totally unencumbered by technical details:
> 
> EVMS has been much more present to interested parties than LVM2. If --
> as a user -- I was to choose either one RIGHT NOW (i. e. with a gun
> against a head, a boss telling me 'I want a decision in 30 minutes', you
> name it), I'd go for EVMS.
> 
> But because EVMS just looks much less like a construction site than
> dm2/LVM2 does.
> 
> Just my two Euro cents.

I'll add my $0.02US which (according to exchange rates) is
worth more though almost worthless.

Hate to say it but in this comparison LVM2 looses.  Primary
reason: Backward compatibility.  People are going to need to
be able to switch between kernels.

So far everything indicates that LVM2 is not compatible with
LVM.  That LVM2 and LVM(1) can coexist-exist is irrelevant if
2.5 hasn't got a working LVM(1).  And that would leave us
with having to do backup+restore around the upgrade.

Any on-disk changes also need to have an in-place translator.
Just think about what it would take to do an upgrade, or
downgrade, without in-place translation.

Also 2.4 -> 2.6 should not be a feature reduction so
snapshot volumes and any other LVM features missing from
LVM2 are issues.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
