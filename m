Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265052AbUD3DlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbUD3DlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUD3DlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:41:03 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:48134 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265052AbUD3Dk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:40:58 -0400
Cc: Paul Jackson <pj@sgi.com>, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors@astro.swin.edu.au>
Subject: Re:  ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-to: <40917F1E.8040106@techsource.com>
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	<20040429133613.791f9f9b.pj@sgi.com>	<409175CF.9040608@techsource.com> <20040429144737.3b0c736b.pj@sgi.com> <40917F1E.8040106@techsource.com>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-22225-31758-200404301332-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Apr 2004 13:37:55 +1000
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> said on Thu, 29 Apr 2004 18:18:06 -0400:
> Paul Jackson wrote:
> > Timothy wrote:
> > 
> >>Perhaps nice level could influence how much a process is allowed to 
> >>affect page cache.
> > 
> > 
> > I'm from the school that says 'nice' applies to scheduling priority,
> > not memory usage.
> > 
> > I'd expect a different knob, a per-task inherited value as is 'nice',
> > to control memory usage.
> 
> Linux kernel developers seem to be of the mind that you cannot trust 
> what applications tell you about themselves, so it's better to use 
> heuristics to GUESS how to schedule something, rather than to add YET 
> ANOTHER property to it.

Why is that?

On the desktop system/workstation, which is what we are talking about
here -- we want the desktop system in particular to be responsive --
the user wouldn't try to do anythign malicious, so why not trust the
applications? openoffice and mozilla and my visualisation software are
going to know what they want out of the kernel (possibly with
safegaurds such that they only tell the kernel what they want if the
kernel happens to be in some tested range, perhaps), the kernel sure
as hell won't know what my custom built application wants via
heuristics, because I am doing something that no-one else is, and so
my exact workloads haven't been experienced or designed for.

On a server, you can have a /proc file to tell the kernel to ignore
everything an application tells you, or ignore/believe application
with uid in ranges xx--yy.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Beware of Programmers who carry screwdrivers.
