Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUD3Pfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUD3Pfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUD3Pfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:35:44 -0400
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:33423 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S263028AbUD3Pfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:35:41 -0400
X-BrightmailFiltered: true
To: bart@samwel.tk
Cc: Timothy Miller <miller@techsource.com>, Paul Jackson <pj@sgi.com>,
       vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com> <409175CF.9040608@techsource.com>
	<20040429144737.3b0c736b.pj@sgi.com> <40917F1E.8040106@techsource.com>
	<20040429154632.4ca07cf9.pj@sgi.com> <40918AD2.9060602@techsource.com>
	<1083328293.2204.53.camel@samwel.tk>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Fri, 30 Apr 2004 10:35:31 -0500
In-Reply-To: <1083328293.2204.53.camel@samwel.tk> (Bart Samwel's message of
 "Fri, 30 Apr 2004 14:31:34 +0200")
Message-ID: <yquj65bhtr5o.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Bart Samwel uttered the following:
> 
> Thought experiment: what would happen when you set the hypothetical
> cpu-nice and io-nice knobs very differently?
> 
Dunno why, but this talk of knobs makes me think of the "effects-mix"
knob on my bass amp that controls how much effects-loop signal is
mixed with the "dry" guitar signal.

Getting back to kernel talk, we have a "swappiness" knob, right?
Should there be, or is there already, a way to dynamically vary the
effect of swappiness [within a range], based on some monitored system
characteristics such as keyboard/mouse (HID) input or some other
identifiable profile?  Perhaps this is similar to nice/fairness logic
in the process schedulers.

Using HID as a profile, if I'm up late working on a paper in OO and
using a browser like Mozilla when updatedb fires up, the fact that
there is recent keyboard/mouse input has been seen would modify
swappiness down.

However, if I've fallen asleep in my chair for an hour when updatedb
fires up, no recent input events will have been detected, and updatedb
gets the high range of swappiness effect.  If I happen to wake up in
the middle of it, I just have to accept it'll take time to wake my
apps up, but at least they will get progressively more responsive as I
use 'em.

I use the term "profile" because I wouldn't want to have just HID
events be the trigger.  If a machine's main use is database or
web-serving, perhaps the appropriate events to monitor would be, say,
traffic on specified TCP ports or network interfaces.

The amount of extra work should be no more than what goes on with
entropy generation, I would think.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  "Oh, *that* Physics Prize.  Well, I just substituted 'stupidity' for
      'dark matter' in the equations, and it all came together."
