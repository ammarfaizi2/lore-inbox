Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTKEINe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 03:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTKEINe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 03:13:34 -0500
Received: from us01smtp2.synopsys.com ([198.182.44.80]:51164 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S262410AbTKEINd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 03:13:33 -0500
Date: Wed, 5 Nov 2003 09:11:44 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Ken Foskey <foskey@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K 2.6 test6 strange signal behaviour
Message-ID: <20031105081144.GK2475@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Ken Foskey <foskey@optushome.com.au>,
	linux-kernel@vger.kernel.org
References: <1066654886.5930.57.camel@gandalf.foskey.org> <20031020132805.5e5a59f1.akpm@osdl.org> <1066701370.1079.13.camel@gandalf.foskey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066701370.1079.13.camel@gandalf.foskey.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Foskey, Tue, Oct 21, 2003 03:56:10 +0200:
> On Tue, 2003-10-21 at 06:28, Andrew Morton wrote:
> > Ken Foskey <foskey@optushome.com.au> wrote:
> > >
> > > I have a problem with signals.
> > 
> > You should be using sigsetjmp(), not setjmp().
> 
> No difference.  Note that this is K 2.6 specific, it "works" in K 2.4.
> 
> I am reading on sigaction now, I will recode with SA_RESTART tonight.  

recode it with SA_NOMASK (and please, remove all that forest around the
code if you post it here).

Can someone explain here, how exactly setjmp/longjmp breaks expected
behaviour?

> I think this is not the solution because I am explicitly setting the
> signal handler before every call.  I think this simply leaves the signal
> handler active ie old BSD style.

no. See the glibc source, posix/signal.c

