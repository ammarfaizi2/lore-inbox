Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272718AbTHKOaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272671AbTHKO3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:29:52 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:11403
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272686AbTHKO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:28:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Martin Schlemmer <azarah@gentoo.org>, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH]O14int
Date: Tue, 12 Aug 2003 00:33:32 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308090149.25688.kernel@kolivas.org> <3F376597.9000708@cyberone.com.au> <1060610663.13256.76.camel@workshop.saharacpt.lan>
In-Reply-To: <1060610663.13256.76.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120033.32391.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 00:04, Martin Schlemmer wrote:
> I did not say the 'make -j10s' starved.  I am saying that mouse
> is laggish, as well as window/desktop switching.

No, but I did. With the vanilla scheduler, a normal user can turn X into a cpu 
hog and starve cc1s for 3 seconds, and the more X like applications there are 
on the machine, the longer they can all sit around starving something else. 
Feeling ok on one machine is not enough to say it's fine.

> Also, I am not saying Con should fix it - I am asking if we really
> want one scheduler that should try to do the right thing for SMP
> *and* UP.

No, the same issues that apply to fairness, interactivity, throughput and 
latency are there regardless of SMP or UP. I've had good reports from SMP in 
the past; your HT report is the first that it was bad, and I've said that 
some fairness issues have been addressed which cause those. 

The current scheduler (with or without some tweak or other) will be in 2.6 and 
should work as much of the time, in as many settings as possible, well. Since 
I'm trying to work on it I hope you can report exactly what your issue is and 
I'll try and address it. Do you really compile jobs make -j10 each time while 
using your machine? (rhetoric question of course since there is absolutely no 
advantage to doing that without lots of cpus). If not, how does it perform 
under your real world conditions?

Con

