Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992608AbWJTSNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992608AbWJTSNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992561AbWJTSNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:13:05 -0400
Received: from www.osadl.org ([213.239.205.134]:5555 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030305AbWJTSND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:13:03 -0400
Subject: Re: various laptop nagles - any suggestions?   (note:
	2.6.19-rc2-mm1 but applies to multiple kernels)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: teunis <teunis@wintersgift.com>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061020110746.0db17489.akpm@osdl.org>
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 20:13:54 +0200
Message-Id: <1161368034.5274.278.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 11:07 -0700, Andrew Morton wrote:
> > > So you're saying that CONFIG_NO_HZ breaks the touchpad?
> > 
> > yes.  At least for Acer Travelmate 8000 and HP nx6310 and HP nx7400.
> > Other than the touchpad - there is not a lot of common hardware between
> > these units.   The readout becomes highly unreliable.   (in X it starts
> > jumping around - it SORT OF resembles the output)
> > 
> > My suspicion is a timing problem in the synaptic USB driver
> 
> OK, that's going to be hard to fix and it'd be awkward (and unpopular) to
> make inclusion of the dynamic-ticks feature dependent on fixing this. 
> (Then again, it'd get Ingo into device drivers ;))

Maybe Ingo is the lesser evil than me when it comes down to device
drivers :)

> However I would suggest that NO_HZ (at least) be dependent upon
> CONFIG_EXPERIMENTAL, no?

Fair enough.

> Also, NO_HZ breaks my laptop (and presumably quite a few others) quite
> horridly, which means nobody can ship the feature.  Some runtime
> turn-it-off work needs to be done there.

We can make a commandline switch as for highres. Is that sufficient ?

	tglx


