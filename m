Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264989AbUD3Pq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbUD3Pq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3Pq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:46:26 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:12075 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264989AbUD3PqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:46:21 -0400
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
From: Bart Samwel <bart@samwel.tk>
Reply-To: bart@samwel.tk
To: Clay Haapala <chaapala@cisco.com>
Cc: Timothy Miller <miller@techsource.com>, Paul Jackson <pj@sgi.com>,
       vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <yquj65bhtr5o.fsf@chaapala-lnx2.cisco.com>
References: <40904A84.2030307@yahoo.com.au>
	 <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	 <20040429133613.791f9f9b.pj@sgi.com> <409175CF.9040608@techsource.com>
	 <20040429144737.3b0c736b.pj@sgi.com> <40917F1E.8040106@techsource.com>
	 <20040429154632.4ca07cf9.pj@sgi.com> <40918AD2.9060602@techsource.com>
	 <1083328293.2204.53.camel@samwel.tk>
	 <yquj65bhtr5o.fsf@chaapala-lnx2.cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083339885.2204.61.camel@samwel.tk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Apr 2004 17:44:46 +0200
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: bsamwel@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 17:35, Clay Haapala wrote:
> On Fri, 30 Apr 2004, Bart Samwel uttered the following:
> > 
> > Thought experiment: what would happen when you set the hypothetical
> > cpu-nice and io-nice knobs very differently?
> > 
> Dunno why, but this talk of knobs makes me think of the "effects-mix"
> knob on my bass amp that controls how much effects-loop signal is
> mixed with the "dry" guitar signal.
> 
> Getting back to kernel talk, we have a "swappiness" knob, right?
> Should there be, or is there already, a way to dynamically vary the
> effect of swappiness [within a range], based on some monitored system
> characteristics such as keyboard/mouse (HID) input or some other
> identifiable profile?  Perhaps this is similar to nice/fairness logic
> in the process schedulers.

This kind of thing is exactly what has been avoided by using
interactivity boosts, and taking that into account in an "io-nice" value
as well should solve that. Other profiles might be interesting though.

Interactive tasks have a tendency to be interactive for a short while,
and then be noninteractive for a long time. I'm thinking that it might
be worthwhile to do something with that, i.e. to keep a bonus for "past
interactivity" on some pages based on the fact that they were originally
loaded by a still-existing process that was once/is marked as
interactive.

--Bart
