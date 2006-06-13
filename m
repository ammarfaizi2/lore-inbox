Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWFMWox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWFMWox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWFMWox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:44:53 -0400
Received: from gw.openss7.com ([142.179.199.224]:18865 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964790AbWFMWow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:44:52 -0400
Date: Tue, 13 Jun 2006 16:44:48 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060613164448.A7232@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chase Venters <chase.venters@clientec.com>,
	Daniel Phillips <phillips@google.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>; from chase.venters@clientec.com on Tue, Jun 13, 2006 at 05:00:53PM -0500
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase,

On Tue, 13 Jun 2006, Chase Venters wrote:
> 
> Look out for that word (stable). Judging from history (and sanity), 
> arguing /in favor of/ any kind of stable module API is asking for it.

I was really just using Daniel's words.  I am all too aware that kernel
APIs are unstable.  To some it is a serious failing of Linux
(particularly those involved in porting kernel modules from branded UNIX
or embedded RTOS).  To those whatever stability that can be offered is a
boon.  To those, even worse is the lack of an ABI (even for a single
kernel version).

> 
> At least some of us feel like stable module APIs should be explicitly 
> discouraged, because we don't want to offer comfort for code 
> that refuses to live in the tree (since getting said code into the tree is 
> often a goal).

And that would be fine if we were completely agnostic toward what was
included in mainline, but we are not.  A particular case in point that
I deal with are STREAMS modules.  STREAMS continues to be forbidden from
the tree.  Nevertheless, STREAMS has historically provided one of the
most widespread mechanisms for providing value-added drivers to branded
UNIX or embedded RTOS offerings.  As a result, a large body of existing
drivers are cut off from the tree regardless of their licensing terms.

(Note that these is seldom a question of derivation for these drivers as
they are fully functioning on other operating systems: branded UNIX or
embedded RTOS.)

> 
> I'm curious now too - can you name some non-GPL non-proprietary modules we 
> should be concerned about? I'd think most of the possible examples (not 
> sure what they are) would be better off dual-licensed (one license 
> being GPL) and in-kernel.

Any open-source license not compatible with the GPL.  One that comes to
mind is OpenSolaris drivers.  I'm sure that there are others because there
are many license that qualify as open source licenses that are incompatible
with the GPL.  For example, pure BSD is incompatible with GPL.

Another thing to consider is that the first step for many organizations in
opening a driver under GPL is to release a proprietary module that at least
first works.  The second step is to jump through the hoops and over the
hurdles necessary to open what has been to date proprietary code that may
contain intellectual property issues across a number of organizations.

In adopting a policy that hinders this process, we, instead, discourage
opening of drivers and inclusion in mainline, rather than promoting it.

Sorry for the rant.
