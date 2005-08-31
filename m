Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVHaHpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVHaHpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVHaHpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:45:01 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:20150 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932462AbVHaHpA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:45:00 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 31 Aug 2005 10:44:19 +0300
From: Tony Lindgren <tony@atomide.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831074419.GA1029@atomide.com>
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508301701.49228.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alistair John Strachan <s0348365@sms.ed.ac.uk> [050830 18:57]:
> On Tuesday 30 August 2005 13:31, Tony Lindgren wrote:
> [snip]
> > >
> > > Same issue, it's waiting on dynticks before being reworked.
> >
> > Also one more minor issue; Dyntick can cause slow boots with dyntick
> > enabled from boot because the there's not much in the timer queue
> > until init.
> >
> > This probably does not show up much on x86 though because of the
> > short hardware timers.
> 
> You could disable it until jiffies >= 0; this covers the boot criteria and 
> still allows for moderate savings post boot (though maybe on embedded systems 
> the delay is too long?).

Yeah, that's true. Or just enable it from an init script via sysfs.

Tony
