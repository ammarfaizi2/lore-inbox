Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272702AbTHKPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272712AbTHKPZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:25:25 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:47608 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272702AbTHKPZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:25:19 -0400
Subject: Re: [PATCH]O14int
From: Martin Schlemmer <azarah@gentoo.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308120033.32391.kernel@kolivas.org>
References: <200308090149.25688.kernel@kolivas.org>
	 <3F376597.9000708@cyberone.com.au>
	 <1060610663.13256.76.camel@workshop.saharacpt.lan>
	 <200308120033.32391.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060615179.13255.133.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 17:19:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 16:33, Con Kolivas wrote:

> > Also, I am not saying Con should fix it - I am asking if we really
> > want one scheduler that should try to do the right thing for SMP
> > *and* UP.
> 
> No, the same issues that apply to fairness, interactivity, throughput and 
> latency are there regardless of SMP or UP. I've had good reports from SMP in 
> the past; your HT report is the first that it was bad, and I've said that 
> some fairness issues have been addressed which cause those. 
> 
> The current scheduler (with or without some tweak or other) will be in 2.6 and 
> should work as much of the time, in as many settings as possible, well. Since 
> I'm trying to work on it I hope you can report exactly what your issue is and 
> I'll try and address it. Do you really compile jobs make -j10 each time while 
> using your machine? (rhetoric question of course since there is absolutely no 
> advantage to doing that without lots of cpus). If not, how does it perform 
> under your real world conditions?
> 

Normal run of things there is many times 1-3 'make -j6s' running.
Yes, sure, for on of them you prob should use -j4, but hey its
in the head, right =).  No, it is not kernels, it is a variety
of stuff - goes with the distro i guess.  Yes, I have tested
runs of 'make -j12' and 'make -j24' (sorry, should have been more
precise, but -j{6,12,24) was used as testing, with -j6 default)
running dual makes.

With vanilla the mouse pointer, XMMS, switching desktops or
windows is smooth.  If I really hammer the system, it does
'slow down' the general navigation of X a little, but not
so that that mouse pointer is jerky, etc.  With the O??int
patches things starts to 'stutter' under loads that is fairly
under those that vanilla handles fine.  The mouse gets jerky,
switching desktops is notably lagging.

Note that I am not talking about starving XMMS/the make's.
I am just talking general navigation of X.  Yes, even with
vanilla things do start a bit slower, but the mouse goes
where it should, and its not as if the vga struggles to
redraw the screen on desktop switch.  I do not expect the
system to behave for 'interactive' processes and xmms/whatever
as if there is no load - the signs of load is just way more
than with vanilla.


Regards,

-- 
Martin Schlemmer


